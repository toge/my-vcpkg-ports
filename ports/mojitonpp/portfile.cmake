set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/mojitonpp
    REF b0253a600af893c366011834a7faad5568c45469
    SHA512 b6b2eab4a73eb8388ff4ea4e90f10d443f8d6b4e2a9b4a2c9b4c29bcb38f049d95a2a5d7a6a73fff75944f4faf496912a91a72d3ae8cf94d1be727e0476fd37e
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/mojitonpp")

vcpkg_copy_tools(
    TOOL_NAMES sequence_detector
    AUTO_CLEAN
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
