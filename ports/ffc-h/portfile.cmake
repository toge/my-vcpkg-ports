set(VCPKG_BUILD_TYPE release) # header only library
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO kolemannix/ffc.h
    REF "v${VERSION}"
    SHA512 55f2916b544f5eed75e43d0c5bf693d9f9f1907f9af1a325aa587a50837aff24524e94efd8baaf565f738007222f0955115e8b5b1121845e640bd12967bc582b
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
