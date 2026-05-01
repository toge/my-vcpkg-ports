set(VCPKG_BUILD_TYPE release) # header-only port
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO kolemannix/ffc.h
    REF "v${VERSION}"
    SHA512 a1a9a2f5c5af2062c0f2477df0e3cb59ed7733e7dc56bb5dade69a8d47b1a4f5a6f0fc397c02ebf78f4a6d77fc5a543f6dda1a837b73a6bee5e5d729a51df976
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME ffc CONFIG_PATH lib/cmake/ffc)
file(COPY "${CMAKE_CURRENT_LIST_DIR}/ffcConfig.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/ffc/")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE-APACHE" "${SOURCE_PATH}/LICENSE-BOOST" "${SOURCE_PATH}/LICENSE-MIT")
