vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO eisenwave/ulight
    REF v${VERSION}
    SHA512 0b058dcda5700a1a1b878ddebedd0abc95383207fd22fd2e161145ab15463468be4ca6ce0ee66fc81e9354c41b752f16920ed3bb3b35d52bbde93a032935a768
    HEAD_REF main
    PATCHES
        unofficial-cmake-config.patch
        disable-tests.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME unofficial-ulight)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
