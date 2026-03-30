set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/glz-util
    REF 659cdb93534d23e94db99682727519818a8e13c5
    SHA512 79972a601f790cf126c29d9e52201118d24170698327fb7f3e50e65e132417358235fe572438d8eace9a8d85f847abedb01986a0964d3b3e31643868567e5f1c
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
