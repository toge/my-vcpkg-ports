# pcre2cpp port design

## Problem

Add a new `pcre2cpp` port to this custom vcpkg registry for the upstream project at
`https://github.com/MAIPA01/pcre2cpp`.

The upstream project is a header-only CMake package that exports a package config and
declares `mstd` and `pcre2` as dependencies in its installed config. Because `mstd`
is not already present in this registry, the work must package both `mstd` and
`pcre2cpp` so that `find_package(pcre2cpp CONFIG REQUIRED)` works through vcpkg-managed
dependencies.

## Upstream facts

- `pcre2cpp` latest selected tag: `v1.2.6` (`f41d649a6844b3da316d743452f77a2c58f441d4`)
- `mstd` upstream-tested compatible version: `v1.5.3` (`cf4cd60f8ceaf223a39df4aab02d6e6e5d09f9a4`)
- `pcre2cpp` requires external `mstd` and `pcre2` when configured with
  `PCRE2CPP_MSTD_EXTERNAL=ON` and `PCRE2CPP_PCRE2_EXTERNAL=ON`
- `mstd` requires external `fmt` when configured with `MSTD_FMT_EXTERNAL=ON`
- Both upstream projects install CMake package files into a top-level `cmake/`
  directory and expose interface targets

## Considered approaches

### 1. Package `mstd` and `pcre2cpp` separately

This is the selected approach.

Pros:

- Matches upstream dependency model
- Keeps all dependencies under vcpkg control
- Preserves reusable `find_dependency(...)` behavior
- Minimizes long-term divergence from upstream

Cons:

- Requires adding two ports instead of one

### 2. Package only `pcre2cpp` and let upstream download `mstd`

Pros:

- Less work initially

Cons:

- Pulls dependencies outside vcpkg management
- Hurts reproducibility and cacheability
- Makes the installed package behavior less predictable

### 3. Repackage `pcre2cpp` manually with a custom config file

Pros:

- Could avoid adding an `mstd` port

Cons:

- Diverges from upstream install/export logic
- Higher maintenance cost
- Higher risk of config mismatch for downstream consumers

## Selected design

### Package layout

Add two new ports:

1. `ports/mstd`
2. `ports/pcre2cpp`

Each port will include:

- `portfile.cmake`
- `vcpkg.json`
- patch files only if upstream install/export behavior fails under vcpkg

Update the registry versions metadata under `versions/` for both new ports.

### Versioning

Use upstream tags:

- `mstd`: `version-string` `1.5.3`
- `pcre2cpp`: `version-string` `1.2.6`

This matches the user's explicit choice to package the latest stable tag rather than
the moving `main` branch tip.

### Dependency model

`mstd` dependencies:

- `fmt`

`pcre2cpp` dependencies:

- `mstd`
- `pcre2`

The implementation must preserve the base package and documented component behavior for
`pcre2cpp`, not just bare `find_package(pcre2cpp CONFIG REQUIRED)`.

### Build configuration

Treat both packages as header-only/interface libraries.

For `mstd`, configure with:

- `MSTD_FMT_EXTERNAL=ON`
- `MSTD_BUILD_TESTS=OFF`
- `MSTD_BUILD_DOCUMENTATION=OFF`

For `pcre2cpp`, configure with:

- `PCRE2CPP_MSTD_EXTERNAL=ON`
- `PCRE2CPP_PCRE2_EXTERNAL=ON`
- `PCRE2CPP_BUILD_TESTS=OFF`
- `PCRE2CPP_BUILD_BENCHMARK=OFF`
- `PCRE2CPP_BUILD_DOCUMENTATION=OFF`

Because these are interface libraries, the portfiles should remove unnecessary output
trees after install so the resulting package only contains headers, config files, and
copyright information.

### CMake package handling

Both upstream projects install package config files into `cmake/` rather than a vcpkg
standard location. The portfiles should therefore run `vcpkg_cmake_config_fixup()` with
`CONFIG_PATH cmake`.

The design intentionally keeps upstream-generated package config and targets files,
because those files already encode the component targets and dependency behavior.
However, both upstream projects currently export consumer-facing interface compile and
link options that are appropriate for building the library itself but not for downstream
users, such as warning-as-error flags and static-link flags. The implementation plan
must therefore include minimal patches so those options stay build-only and do not leak
through installed imported targets.

### Patch policy

`mstd` should start with a minimal consumer-interface cleanup patch if packaging confirms
that its installed imported target exports build-only warning or link flags.

`pcre2cpp` should assume one small compatibility patch is likely needed across both its
build tree and installed config layer, because upstream configure and package logic
expect `pcre2-8`, `pcre2-16`, and `pcre2-32` targets while the vcpkg `pcre2` port
documents `PCRE2::8BIT`, `PCRE2::16BIT`, `PCRE2::32BIT`, and `PCRE2::POSIX`.

`pcre2cpp` should also assume a minimal consumer-interface cleanup patch if its exported
targets leak build-only warning or static link flags to consumers.

Beyond those known issues, only add minimal patches if needed to fix one of these
blocking issues:

- broken installation layout under vcpkg
- dependency discovery failure in installed config files
- unwanted test/benchmark/doc code paths that cannot be disabled by options

Do not introduce unrelated cleanups or broader refactors.

### Validation

Validate by installing the new port through the overlay registry on `x64-linux`, then
run a downstream CMake smoke test that calls `find_package(mstd CONFIG REQUIRED)` and
`find_package(pcre2cpp CONFIG REQUIRED)`, links against the exported targets, and builds
an actual consumer executable. The smoke test should also cover at least one documented
`pcre2cpp` component target so component export behavior is validated, not assumed.

Success means:

- `mstd` installs cleanly
- `pcre2cpp` installs cleanly with `mstd` and `pcre2`
- installed package configs remain discoverable through vcpkg
- the downstream smoke test resolves the `pcre2cpp` package without target-name breakage
- the downstream smoke test does not inherit inappropriate consumer flags such as
  warning-as-error or forced static link options from `mstd` or `pcre2cpp`
- at least one documented `pcre2cpp` component target resolves and links successfully

## Notes for planning

- `pcre2cpp` depends on `mstd`, so `mstd` must be created first
- both ports are cross-platform CMake packages and should preserve upstream install/export
  behavior as much as possible
- patch only the known translation and consumer-interface issues unless a concrete new
  packaging failure appears
