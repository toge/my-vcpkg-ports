set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/macad-parser
    REF e79979a19911bf052ede2b336f9c345d5d03b202
    SHA512 e9e50fe58ac1e9ed1658ff4fcd233c9f170d17e80882df7b92e2b7cb4b1872e630b95ee2219342484e394a8d3aa9a8040b96d7be838cfe684c79e5d5a580ba10
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/macad-parser)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
