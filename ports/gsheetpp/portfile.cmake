vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/gsheetpp
    REF 433bdc2d9082815d17d7c96cfb8387ca30ae35a0
    SHA512 84888e0f5da2fad54a5043b87c59dc7aa2b9fc5fea9c6d4e85758e7656cf6fb4f558d4d06b92cf5784892399c4679932a0c0f80617864932e8edc40e3b1ca428
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
