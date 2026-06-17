set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/lexborpp
    REF 4087f44a90a1cec08435a6eb24ee01e153bf3b58
    SHA512 95b85b67cc32becd01a4d80e8c45c981cae344101f7126fd65a69d606b5ff845fc64445b5201f2a35666c3b83f9cd2f821e15f40fd8a3e9b50bc57e87528cbdc
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
        -DBUILD_BENCH=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/lexborpp")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
