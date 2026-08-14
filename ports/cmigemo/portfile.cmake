vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO koron/cmigemo
    REF v${VERSION}
    SHA512 24ec37c288bbe6c08faf140b2bbe455f61dd41981138abde8204436d4d00ea90d07a9d16fcce23e9def5c65d8de6f35dd04db0378272ec3a7af110553953e0d0
    HEAD_REF main
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
