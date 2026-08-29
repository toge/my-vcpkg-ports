vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO jinja2cpp/Jinja2Cpp
    REF 79af49f6f9a8a552edb9c1932d4a73a5895b1d32
    SHA512 ecc8bbc2915eb3480e04e51b1a2ad8a90853838c384fb8bd6854d9a1fb68e15700ca5fec64a8f2ff7111fd61e17213079f950998c5bb1ade3ce1dce63b79ef56
    HEAD_REF master
    PATCHES
        fix-vcpkg-deps.patch
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    set(JINJA2CPP_BUILD_SHARED OFF)
else()
    set(JINJA2CPP_BUILD_SHARED ON)
endif()

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        std-regex   USE_STD_REGEX
)

if("std-regex" IN_LIST FEATURES)
    set(_regex_opt "-DJINJA2CPP_USE_REGEX=std")
else()
    set(_regex_opt "-DJINJA2CPP_USE_REGEX=boost")
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DJINJA2CPP_DEPS_MODE=external
        -DJINJA2CPP_BUILD_SHARED=${JINJA2CPP_BUILD_SHARED}
        -DJINJA2CPP_BUILD_TESTS=OFF
        -DJINJA2CPP_STRICT_WARNINGS=OFF
        -DJINJA2CPP_INSTALL=ON
        -DJINJA2CPP_WITH_JSON_BINDINGS=boost
        ${_regex_opt}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME jinja2cpp CONFIG_PATH lib/jinja2cpp)

# Upstream installs to lib/jinja2cpp, config is handled; also clean up
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share"
                    "${CURRENT_PACKAGES_DIR}/debug/include"
)

# The upstream installs header-only dep configs into the same lib/jinja2cpp dir;
# they are already handled by vcpkg_cmake_config_fixup, keep them.

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

# Fixup pkgconfig if installed
vcpkg_fixup_pkgconfig()
