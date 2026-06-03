vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO 0xeb/fastmcpp
    REF 1cd32e0ec5cc7bc0ecc5ed0f00895ce478f2dbce
    SHA512 029580240175cab717a1e6b84dbba5f1f7e3e03eea4dfe409ea11315d90f1d4e057dd1e3a583dac218b7a8678a7320a719d751da4ad8232d9949717a8347e1ee
    HEAD_REF main
    PATCHES
        devendoring.patch
        fix-json-optional.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DFASTMCPP_BUILD_TESTS=OFF
        -DFASTMCPP_BUILD_EXAMPLES=OFF
        -DFASTMCPP_ENABLE_POST_STREAMING=OFF
        -DFASTMCPP_FETCH_CURL=OFF
        -DFASTMCPP_ENABLE_SAMPLING_HTTP_HANDLERS=OFF
        -DFASTMCPP_ENABLE_OPENSSL=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/unofficial-fastmcpp PACKAGE_NAME unofficial-fastmcpp)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

