vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO wtarreau/libslz
    REF "v${VERSION}"
    SHA512 4a23e0feac72a6a5eb47724f60d719bdc41fac29cfb6c2308f56020fa495bb6b1962693d28259bb95f65030654e7c3e5710f11f7dcb93315d7f57ffd94e996ad
    HEAD_REF master
    PATCHES
        add-cmake-build.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(
    PACKAGE_NAME unofficial-libslz
    CONFIG_PATH lib/cmake/unofficial-libslz
)

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
