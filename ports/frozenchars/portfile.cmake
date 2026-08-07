set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/frozenchars
    REF v${VERSION}
    SHA512 8722c565abb54fbbc7f99aff3a36e6b37fffee2abd6b514db85fee600139649e0f29339085758c54031b57dc4790d3b031a41afa54e42049cae658372e2c7e9e
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DFROZENCHARS_BUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/frozenchars")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
