vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO alibaba/zvec
    REF v${VERSION}
    SHA512 11d363c8086a0b5f7146a80fb0df59eb04334aac1a1d9f099a9527f6ad19e6d631ec6753adfea0de504364e42357abdd4173ad9d6c64fea0e59171c835bed55c
    HEAD_REF main
    PATCHES
        fix-add-library-macro-conflict.patch
        devendoring.patch
        fix-antlr4-13-compat.patch
        unofficial-cmake-config.patch
)

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TOOLS=OFF
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(
    PACKAGE_NAME unofficial-zvec
    CONFIG_PATH share/unofficial-zvec
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share"
                    "${CURRENT_PACKAGES_DIR}/debug/include"
)
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
