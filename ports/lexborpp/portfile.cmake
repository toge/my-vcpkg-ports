set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/lexborpp
    REF a9b4566ead8e8d0604f9a54fdbd2519ab61a5bb8
    SHA512 736d94a93042617acb420310dbb97cfabb3fc62fefabac64a5e8dadde6dd6ef85f9359ef9766b093aaf53aad1b1ce7615ffec61efd44f26db43e16b75cf8dda6
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/lexborpp")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
