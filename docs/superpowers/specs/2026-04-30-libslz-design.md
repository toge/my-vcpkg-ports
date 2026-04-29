# libslz port design

## Problem

Add a new `libslz` port to this custom vcpkg registry for the upstream project at
`https://github.com/wtarreau/libslz`.

The upstream project is a small C compression library distributed with a Makefile that
builds a static library, a shared library, and two command-line tools. This registry
needs a reusable library port that can be installed through vcpkg and consumed by other
projects without depending on upstream's Unix-oriented install rules.

## Upstream facts

- selected upstream release: `v1.2.2`
- selected upstream commit for that release: `9a4be37572673a4651ca8ae53c2c55840d115f74`
- upstream source layout exposes the library in `src/slz.c` and `src/slz.h`
- upstream `Makefile` builds `libslz.a`, `libslz.so`/`libslz.dylib`, plus `zdec` and
  `zenc`
- upstream `Makefile install` copies the library and header into `/usr/local`-style
  locations and strips tools, which is not a good direct fit for vcpkg packaging
- upstream license file is MIT/X11-style text in `LICENSE`
- no existing official `libslz` port was found in the upstream `microsoft/vcpkg` ports
  tree

## Considered approaches

### 1. Add a small CMake shim and package only the library

This is the selected approach.

Pros:

- aligns with vcpkg's normal configure/install flow
- avoids upstream assumptions about `gcc`, symlinks, `strip`, and `/usr/local`
- makes static/shared handling cleaner across triplets
- keeps the port focused on the reusable library surface

Cons:

- requires carrying a small patch or injected build script

### 2. Drive the upstream Makefile directly

Pros:

- less code up front
- stays closer to upstream's current build entry point

Cons:

- tied to Unix Makefile behavior
- harder to make deterministic across triplets
- upstream install target includes tool-specific behavior that the library port does not
  need

### 3. Package the library and the `zdec`/`zenc` tools together

Pros:

- closest to upstream's default artifact set

Cons:

- expands scope beyond the library requested here
- introduces extra packaging decisions around tools that are not needed for core library
  consumption
- increases maintenance surface without clear benefit

## Selected design

### Package layout

Add one new port:

1. `ports/libslz`

It will contain:

- `vcpkg.json`
- `portfile.cmake`
- a minimal patch if needed to add or enable a CMake-based build/install path

Update registry metadata in:

- `versions/l-/libslz.json`
- `versions/baseline.json`

### Versioning

Use upstream stable release `v1.2.2`, recorded in the port as:

- `version-string`: `1.2.2`
- `port-version`: `0`

### Build and install model

Do not use the upstream Makefile as the packaged install surface. Instead, add a minimal
CMake shim that builds the `slz` library from `src/slz.c`, installs `src/slz.h`, exports
a package config, and leaves vcpkg in control of package layout.

The initial package scope is:

- the `slz` library
- the public header `slz.h`
- copyright/license metadata

The initial package scope explicitly excludes:

- `zdec`
- `zenc`

This keeps the port aligned with the user's request for the library itself and avoids
bringing extra executables into the first version of the package.

### Consumer package config

The port should install an exported CMake package so downstream projects can use:

- `find_package(unofficial-libslz CONFIG REQUIRED)`
- imported target `unofficial::libslz::slz`

The design goal is to expose a normal imported target for the library rather than forcing
consumers to discover include paths and library filenames manually.

### Platform scope

The implementation should target Unix-like triplets first and should aim to support both:

- static linkage
- shared linkage

through the normal vcpkg linkage model rather than hard-coding a single library type.

Support should only be advertised where the packaged build is verified or clearly
well-formed. If implementation shows that the source or shim is not viable for a platform
such as Windows/MSVC, the port should fail explicitly on that platform instead of shipping
a silently broken configuration.

The implementation should leave `supports` unrestricted at first, then narrow it only if
verification shows a real platform/compiler limitation.

### Cleanup policy

Follow the registry's existing pattern after install:

- remove unnecessary `debug/include`
- remove unnecessary `debug/share`
- remove any other obviously redundant output produced by the build flow if the package is
  meant to ship only the library/config/header/license set

### Validation

Validation should cover:

1. overlay installation of `libslz` on `x64-linux`
2. overlay installation of `libslz` on a static-linkage Linux triplet such as
   `x64-linux-static` if the environment provides it
3. a downstream CMake smoke test that uses `find_package(unofficial-libslz CONFIG
   REQUIRED)` and links `unofficial::libslz::slz`
4. presence of the installed header, library, and CMake package files in the resulting
   package tree
5. registry version metadata generation for the new port

Success means:

- `libslz` installs cleanly through the overlay port
- `libslz` also installs cleanly for a static-linkage Linux triplet when that triplet is
  available in the local vcpkg setup
- a downstream consumer configures and links against `unofficial::libslz::slz`
- the package contains the expected library/header/license/config artifacts
- the generated versions metadata correctly registers `libslz` in this registry

## Notes for planning

- upstream release integrity must be locked with a source SHA512
- prefer minimal divergence from upstream source layout; only patch enough to create a
  clean vcpkg-native build/install path
- do not add unrelated tool packaging or broader refactors in the first port revision
