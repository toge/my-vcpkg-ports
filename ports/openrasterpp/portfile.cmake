vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/openrasterpp
    REF 02170cdf5d89949ab6c16442e26fdc8c81c12341
    SHA512 15eb8cc2e623133ed7c53099951f505ca1176ac0fbd8d2c479bca0578f18c45128a33715f4341d6f45e155ceb4e21d6c4302a0bdd11d9b6ddc59abbc4b2ece36
    HEAD_REF main
    PATCHES
        disable-tests.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TESTING=OFF
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/openrasterpp")

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
