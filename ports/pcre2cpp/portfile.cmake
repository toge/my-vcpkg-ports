vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO MAIPA01/pcre2cpp
    REF "v${VERSION}"
    SHA512 359d2b1a62eec1bd80521aa4c105946d6f7fc64c7c041aa0aeffa01933b1a10e40057f44d4137c33ba184224ae96ec332ca41deaa65d1463d234a1309e719ef5
    HEAD_REF main
    PATCHES
        fix-pcre2-targets-and-consumer-interface.patch
)

set(VCPKG_BUILD_TYPE release)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DPCRE2CPP_MSTD_EXTERNAL=ON
        -DPCRE2CPP_PCRE2_EXTERNAL=ON
        -DPCRE2CPP_BUILD_TESTS=OFF
        -DPCRE2CPP_BUILD_BENCHMARK=OFF
        -DPCRE2CPP_BUILD_COVERAGE=OFF
        -DPCRE2CPP_BUILD_DOCUMENTATION=OFF
        -DPCRE2CPP_ENABLE_CLANG_TIDY=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH cmake)

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug"
    "${CURRENT_PACKAGES_DIR}/lib"
)

vcpkg_install_copyright(FILE_LIST
    "${SOURCE_PATH}/LICENSE"
    "${SOURCE_PATH}/LICENSE_PCRE2"
)
