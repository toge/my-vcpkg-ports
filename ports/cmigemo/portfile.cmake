vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO koron/cmigemo
    REF v1.4.1
    SHA512 97204A95A20543B38140174688212BF26CF50432FDB8F9006D691EFE651D37CD0A536055C3E19AC0C58A44367CCE7A075E372F90652494C0E2F158E2F163BBB6
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
