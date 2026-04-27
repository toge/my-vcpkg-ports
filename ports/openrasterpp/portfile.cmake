vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/openrasterpp
    REF a0e68a86165bc3feed2177bd29d28e439c93f487
    SHA512 1401fee15ced792dd1bf174584cb1cbf23ae62452a8c1605dc5e79972bea1950122a1a151c8ab3c0a52502352fa6082874a5de3231987af3fbc534371e3168ed
    HEAD_REF main
    PATCHES
        disable-tests.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TESTING=OFF
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/openrasterpp")

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
