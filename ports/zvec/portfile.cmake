vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO alibaba/zvec
    REF v${VERSION}
    SHA512 1fcb6376020188b0d158c0480fad68c1a0737478e452b4504475927ce68c3a9335534301bf910547adce512bcd08f92a2150ba71d0c2de682271f6e52ee7a71c
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
