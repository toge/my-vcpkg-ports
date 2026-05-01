vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/gsheetpp
    REF a4c122fab0d24165f88fd0f665dc1f7b74d3ca74
    SHA512 8fe750049a213ec1999249fc2d1e5e399425eee40a66d1e16a37f1322513c22a59de011b37871a26da63564794c9c641e8f89e79e115b052788ec55bb3a85ab1
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
