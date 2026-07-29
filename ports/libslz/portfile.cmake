if(VCPKG_TARGET_IS_LINUX OR VCPKG_TARGET_IS_BSD)
    # libslz.so is healthy before vcpkg's ELF RUNPATH rewrite and crashes after it.
    set(VCPKG_FIXUP_ELF_RPATH OFF)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO wtarreau/libslz
    REF "v${VERSION}"
    SHA512 1510507bd4afbe0282ebe82b0af6aa5a3189d393426f52370634ad74b3319c111263b6cf21a728f6e66e0cd36beaa90a8185b99fcf54622e33dba429f078ca3e
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
