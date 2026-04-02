set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/glz-util
    REF a1270e8e9cdc96db6055ddbbd2ed9c453263eaf4
    SHA512 bdba4fb929b8b493988e350511638fcb54a16d3c3f96d4cf4f2d18f66a0cec035e5cc0155c6157a5c6b6139911fd16fcc508efea8c15788fbb444ed3568c6adf
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
