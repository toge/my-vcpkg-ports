vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO koron/cmigemo
    REF b71e69050a3b4e27138987670cb3fe9d6eedb4f2
    SHA512 BF7CA0D1058B0CDD9EDA079AF2053609D691E15FDF4FCB5BA1CF1EE61DD2812F7AFE94113BBE193012B4856427273109489CC0BBF4BA75BE394506802BFBF0C5
    HEAD_REF main
    PATCHES
        disable-dict.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_DICT=OFF
        -DBUILD_TESTING=OFF
)

vcpkg_cmake_install()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

configure_file(${CMAKE_CURRENT_LIST_DIR}/Config.cmake.in
    ${CURRENT_PACKAGES_DIR}/share/cmigemo/cmigemo-config.cmake @ONLY)

configure_file(${CMAKE_CURRENT_LIST_DIR}/usage
    ${CURRENT_PACKAGES_DIR}/share/cmigemo/usage COPYONLY)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
