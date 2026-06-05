set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/glz-sql
    REF bb7d403b2162cbb8c454e6be157b61211f4a563e
    SHA512 c1625f1ba9f05b503560db803e1e4b73556330ac595dd0be0477223a008b84bebc2d15267660cd921c61f0878234da75bb3b6ce542c6635a3c0ca640e9e793b4
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DENABLE_TESTS=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME glaze-sql CONFIG_PATH "lib/cmake/glaze-sql")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
