set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/uuid7pp
    REF 47504181cded0569d11ce28856b57bd587e14318
    SHA512 a3b2f2e2933f5e325c6da5739179ce6f536c1d9878cb0dda3cce7ad36ccc291cbf24989fcb37f90abb49e8e943b9d0ca87999fce4e2af1d9825cce23e77a13f9
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DENABLE_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/uuid7pp")

# file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
