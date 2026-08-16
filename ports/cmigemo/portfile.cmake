vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO koron/cmigemo
    REF v${VERSION}
    SHA512 60870870469baf1674f775c4ed1616f96f518416f736d989420a2af014905d7038b8e8b62f07f6c68373adf589fb5d5a61e6b054705eab54ea9579e1100e3c0c
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

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
