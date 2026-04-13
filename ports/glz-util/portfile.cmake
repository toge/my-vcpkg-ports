set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/glz-util
    REF 650a1d21bc2df6911e0262332b9fd96c3b757b9b
    SHA512 eb4ec5ada58055cb56f9bd0abae8c1d69c10aef213dc4273b599f257f07f08fbaf07dca0cb1670a673f6e5055abc0c6b3d01965bd5ef8a4f3ddb5ef7ef9c292a
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DENABLE_TESTS=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/glz-util")

vcpkg_copy_tools(TOOL_NAMES json_schema_codegen AUTO_CLEAN)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
