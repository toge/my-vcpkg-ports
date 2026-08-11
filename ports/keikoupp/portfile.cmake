set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/keikoupp
    REF 00f476f827e04214e7deea0834b5a15a84466b9e
    SHA512 8c3118971470dd1dc3d4425f499e5f0e77bdcaedf635de44c527bbe1d7f0f9da5b533f509ee2bb3c21cd393fd605863d68232f16690baa3670a8a6a64658fb78
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
