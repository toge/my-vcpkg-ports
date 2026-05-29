set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/frozenchars
    REF 0e92d8464decb5cd85494b84914055f2c5d798dc
    SHA512 48a83f163f6d9160e8d87e9189f0c2ce2463da10a991cac5deedb09046a2b8356e0349cc61df2ec5db6a4d75fb2bdd61ee901dcff9479d8f19d6771ad5b0e42e
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DENABLE_TESTS=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/frozenchars")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
