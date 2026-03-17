set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/zxcpp
    REF 99fc1e1058fcb3f259354b7fc4a5a6ef11f7d27e
    SHA512 ec79e667a18444d33ccdd9237234a138dab53f3528c26fbebd804e69cff8d79dc37db3819d1f4a7a2cdf6993bebe5982ddafb35507432f55388e5e21d32c22fa
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/zxcpp")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
