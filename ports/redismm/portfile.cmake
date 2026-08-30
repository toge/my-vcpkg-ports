set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/redismm
    REF f83bb45727fe2027a12a8d59afd7b9a5f6a5f084
    SHA512 2d73233ee4dd9cce7c78aed48996e6dfb740060f6a5101942a2d2d33401cd0218c343dff59549e45a32043db04cadb7aaf6e466c5a4f631d72b83256cd77d7b9
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/redismm")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
