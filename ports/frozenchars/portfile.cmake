set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/frozenchars
    REF ff96921d40f0f71ff201c09177b5c55116467862
    SHA512 fce2bb81543213a825f2f3b8942560c27e0ad6a114c4ce8f7c55ae59a33d44e2ffda2bac5a4d55d0ef19763fe2c28629ea0807cd69a090efd3283baf6ce3c845
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/frozenchars")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
