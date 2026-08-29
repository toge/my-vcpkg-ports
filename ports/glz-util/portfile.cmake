set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/glz-util
    REF 750f7e95fc1081ba2f413a3600226e1e8e2b3b60
    SHA512 eb7d5297bf4417b6e3325616e4c0c7b29cb444ff0673f397ed769018f168d2369f484f7ceaff96afd234e3c2fab26ca03daa72319e1ecaa26ecd977661c06ed0
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

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
