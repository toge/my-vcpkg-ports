vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/gsheetpp
    REF 4fcbc617ee1985f814838f7790151583ea116334
    SHA512 bb923093c585d6f9b24e63f4826aa9013f55453246fd922479fb04d3ddcb0bc2686233348b59e2f0c86528d239450c07c2569a092e29926e156f258d1b91bf18
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
        -DBUILD_EXAMPLE=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/gsheetpp")

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
