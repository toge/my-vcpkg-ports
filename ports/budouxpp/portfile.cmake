set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/budouxpp
    REF 667b4a0ff8c5fdf2ee87e528d592c567e4a51699
    SHA512 d064e3456ceea6783cc08ad3d653f7f186248a99c7fdfdbdb465a9526ea6738ceb972e576e4ba0c040cd5ff1c3208ed902180bfed42531c1bcb551cf3ea0107a
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DENABLE_TESTS=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/budouxpp")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
