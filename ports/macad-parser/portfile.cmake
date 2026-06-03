set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/macad-parser
    REF bbac5b7104317004250dd6254f311d8e7b13b330
    SHA512 d72b140ef83d402fae7a225551480bc04ba6015d1925100a5eda84ba95635967404710c7fbadfc6ecd4be3432655df5ee97105c99e2984daa1d1b3a8ecb2f7dd
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/macad-parser)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
