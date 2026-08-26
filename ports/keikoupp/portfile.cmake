set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/keikoupp
    REF 6af0c7cbb4804fc42f71270e3b7b8022fe6aaec4
    SHA512 2062adb993d4800b540a458b2cc319288459f5a33f50a15656f6c5896890c8ed5cb56b1fb4d44afd6dd8241813ab9d68f8e26854a2a2472f680d503ea6458e51
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/keikoupp")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
