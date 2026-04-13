vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/yase-json
    REF b19cb5ece7769326795c7abc42f8599bd11e25e0
    SHA512 042f7a6da3373936d54a92db9bbfc72d950211f46438beced242ebfc508172428197a43b00fb05e88fcef90dc4138dacb60b54201183cb6298dc1fa914597e07
    HEAD_REF main
)

set(VCPKG_BUILD_TYPE release) # header-only port

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/yase-json)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
