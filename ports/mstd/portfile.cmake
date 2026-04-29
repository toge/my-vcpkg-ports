vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO MAIPA01/mstd
    REF "v${VERSION}"
    SHA512 97a207b164b1b2ed2a4ba759d7ee1570693358e648eccc734df206b2395133e387a88ca9da0efe0a38f4adfe3b12adac78b966b9dc1bd563d37ff6aeea139bf6
    HEAD_REF main
    PATCHES
        fix-consumer-interface.patch
        fix-missing-standard-includes.patch
)

set(VCPKG_BUILD_TYPE release)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DMSTD_FMT_EXTERNAL=ON
        -DMSTD_BUILD_TESTS=OFF
        -DMSTD_BUILD_COVERAGE=OFF
        -DMSTD_BUILD_DOCUMENTATION=OFF
        -DMSTD_ENABLE_CLANG_TIDY=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH cmake)

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug"
    "${CURRENT_PACKAGES_DIR}/lib"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
