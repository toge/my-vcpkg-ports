set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/lexborpp
    REF d903bc4308491d79506d9767d57c3c111a62cf07
    SHA512 87ef73c4d99e6c72aee58649d8813e1642e46bb7cef228db62a8a2983d5c9a4a647237f08cbada258d97988ce84fa5e70d7dbfaeb10151899f46cf14b70bdc3a
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
        -DBUILD_BENCH=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/lexborpp")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
