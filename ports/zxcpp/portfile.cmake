set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/zxcpp
    REF bcc7b7001b274a8981c4322a2048b4cde6877962
    SHA512 eee6264ef70e21c185469d161b5f83dc7aa238cd0f9237c023dcfb51ff8364c5f8ec44d214022cac0fedefcf3a9ea1889977370f090876c89bb9571f1b3c3544
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/zxcpp")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
