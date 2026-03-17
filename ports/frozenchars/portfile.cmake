set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/frozenchars
    REF bfdf2e26a80142b0e33e342be3f33950dd16022a
    SHA512 b3bd447078cccdf0639253d6a05c6d5929a92ab080241783e576390f7d66a922ef50b93ecc4595693a00241449b4700fa1a0c063c826219a80d8211d018c3f0e
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/frozenchars")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
