set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/injamm-sqlite3
    REF 590412543300a04068b3b6470fb80878630ea17f
    SHA512 16a8c2efa6d7633f327bd4d2bd92e7103e10736ee0c6395dc2c0fea760fcbb0b5a299872b5839c1520f5a3ff8076d35cb7d6e73eb46c52838bc237919f16bd47
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
