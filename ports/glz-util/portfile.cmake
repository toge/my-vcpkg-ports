set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/glz-util
    REF 202d97a07e28c1197e5575e748c12c0ed53f433d
    SHA512 1360307aa031c08d3e2f0a5ef85d13b09a9ca1f250f8defc24dbae14eb384181a7aaf446690c63e748985fdc62a7758c0cf8d7a4e9254a06449f82e426aae048
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/glz-util")

vcpkg_copy_tools(TOOL_NAMES json_schema_codegen AUTO_CLEAN)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
