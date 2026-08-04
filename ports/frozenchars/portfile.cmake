set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/frozenchars
    REF v${VERSION}
    SHA512 f75b32e76f98fd6e6eeaf15527f3bfcdd412cad99debc047eb2ee635d36ccec948ff4d7182f8f4755fd041a7311452957c8739282e58ff38b24449cc76b8fed7
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
