vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO MeshInspector/fastmcpp
    REF c5271bc242be0590f7845f96023ddc4f4842e2ba
    SHA512 f9ff13acbd83f558d30f2b7e51ebda8d435d0a5250bdd6752db45c257d364d7e47fe17926380def73b933dfd0e78fb384eb672d6c02e61b7f77095c31b2117cf
    HEAD_REF main
    PATCHES
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
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/fastmcpp PACKAGE_NAME fastmcpp)

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

