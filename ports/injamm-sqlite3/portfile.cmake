set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/injamm-sqlite3
    REF e49181ac8761d9ddd41df25275bef2de7b76acea
    SHA512 438b272aefdb00a45432096f529bb230e944b55c0d28282df122ca477cf04ca32818660657ea66cbb68a40124d80b07f5a28223f52c5a2c5415a6e3379a63c44
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "share/injamm-sqlite3")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
