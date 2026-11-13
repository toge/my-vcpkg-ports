if(VCPKG_TARGET_IS_LINUX OR VCPKG_TARGET_IS_BSD)
    # ponytail: libslz.so crashes after vcpkg RUNPATH rewrite; globally disabling
    # RPATH fixup hides the issue. Revisit if upstream fixes RUNPATH handling.
    # libslz.so is healthy before vcpkg's ELF RUNPATH rewrite and crashes after it.
    set(VCPKG_FIXUP_ELF_RPATH OFF)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO wtarreau/libslz
    REF "v${VERSION}"
    SHA512 dd5936cddbc8aa6981407fd7c4b78a457c43459b91333f9f3af59c1c4a4fb7a8808f39c643833608c5bd0db7b16350c7a0ae365597c20cb7a0c8fb306d02529e
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
