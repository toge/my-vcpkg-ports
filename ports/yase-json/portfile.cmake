vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/yase-json
    REF 307f80b7c0a941ecc9976db7e46c1c7d2efc30d9
    SHA512 c1888d31106e42b0a6e824fef1aa86a3e524fd34df544bb32a2d547d7c8c449a76bf97d910657f649eaa326c7f89bcd596828a17abd2cff7e04b317dd09a2294
    HEAD_REF main
)

set(VCPKG_BUILD_TYPE release) # header-only port

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/yase-json)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
