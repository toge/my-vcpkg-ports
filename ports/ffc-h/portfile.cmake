vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO kolemannix/ffc.h
    REF "v${VERSION}"
    SHA512 fb2fd817dfca69de206924b439f6500d20226db3b0326b517de5ee005cef1c00812f58b89963d23f14bfbb62f580e78c3aa97ba558edd6dca63f8ef33cc7ef79
    HEAD_REF main
)

set(VCPKG_BUILD_TYPE release) # header-only port

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME ffc CONFIG_PATH lib/cmake/ffc)
file(COPY "${CMAKE_CURRENT_LIST_DIR}/ffcConfig.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/ffc/")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE-APACHE" "${SOURCE_PATH}/LICENSE-BOOST" "${SOURCE_PATH}/LICENSE-MIT")
