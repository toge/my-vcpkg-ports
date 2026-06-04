set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/glz-sql
    REF 1bc1db2d5be9276b95f198f7b266305270ad81bb
    SHA512 fd3244dbebc1aa829c175d45d7dd0456f51d7ede59a76443cde7d7c25620a39f0ee5a277fa2e7409f6323fefa0f4b97a38fd10309f97ada8e0420469b70a68a8
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DENABLE_TESTS=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME glaze-sql CONFIG_PATH "lib/cmake/glaze-sql")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
