set(VCPKG_BUILD_TYPE release) # header only library
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO kolemannix/ffc.h
    REF "v${VERSION}"
    SHA512 594d69196fd9c7415c0d9435943331e5fb8b9fc1376821c4d5e198a09ac6a425a0b257dfc22f36ab846ad359936f101e11b8e3bbe47efcf55666f5cce9cc9dd4
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME ffc CONFIG_PATH lib/cmake/ffc)
file(COPY "${CMAKE_CURRENT_LIST_DIR}/ffcConfig.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/ffc/")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE-APACHE" "${SOURCE_PATH}/LICENSE-BOOST" "${SOURCE_PATH}/LICENSE-MIT")
