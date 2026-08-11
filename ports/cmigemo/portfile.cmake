vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO koron/cmigemo
    REF v${VERSION}
    SHA512 a0f4b485ed38255b803517514da82364ce461950866649c6630b2b0350d849171a7b1d1ec2a89c22cc26fba19302ad221de91b1d6bb5356bc64cf020075e162d
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
