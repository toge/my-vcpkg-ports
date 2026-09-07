set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/keikoupp
    REF c0892af885feb2de579d857e622900f085ffa11b
    SHA512 2e370054e9e4195fc0459de13febc6fb3be79f3fab63d7ba63a96ba69c2fdca2c4d1ef56e3698317267d1b0e5eef66e2b27cadd8027bcd562e31605a4f23a83f
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/keikoupp")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
