set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/injamm
    REF 344d680a7b2313710cad277c07e312efa5ea0680
    SHA512 7bf57cd450e388f4796435e5ab29ba840ad69cdc50cea35d872b6b93f9fc70a4070fb2375c1b2d7b0d10b371cdafd23bfdd6d8ee4db4cfc89f0a9381c0e77c64
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DINJAMM_BUILD_TESTS=OFF
        -DINJAMM_BUILD_EXAMPLES=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/injamm")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
