set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/zxcpp
    REF d113f8c03e7059b2a311c0de648eacdcec0db5e0
    SHA512 5cfae84858e5b3ccd1109c314eb65209c96202947da4d8ec7c5c86492f8c66d2a0559d4ed3f349ac6f5180c522c08759fe69282a7f2454723978fde43b97e8a0
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/zxcpp")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
