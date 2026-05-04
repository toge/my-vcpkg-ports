vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/gsheetpp
    REF e24836b02ba83edc70dec2a7c863c1e06c3f4240
    SHA512 42b2fb6e93ce824b5be2152183690e271b375547dd3bc23eac5adb019ca1d5344c3566bd4f9c5652dd18bf11c1e0802d3e83ef0e8b70d5eaeb66930b9b31a4b9
    HEAD_REF main
    PATCHES
        disable-example-and-tests.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TESTING=OFF
        -DGSHEETPP_BUILD_EXAMPLE=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/gsheetpp")

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
