vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO koron/cmigemo
    REF v${VERSION}
    SHA512 210e291430e3cd500b6c75c17160b5cc2a33818cfbcab121cd57b6544d4af41b166d5412562a4ec1ecb856c5783cb9c810f099ae4f0f7f1ffba59a0a83f9d5a2
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
