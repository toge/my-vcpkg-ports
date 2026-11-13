if(VCPKG_TARGET_IS_WINDOWS)
    # ponytail: tree-sitter parsers use static linkage on Windows (upstream lacks DLL export)
    vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO uyha/tree-sitter-cmake
    REF "v${VERSION}"
    SHA512 b8b6c10f5a9a02aee690ac3289c4d4a47690d4c44fc2d59a78c7cc78c1346c87e5ee827e2cfa01a4bea37fbb48948da893ae2e63cbb9a84328fb2d08acce025d
    HEAD_REF master
    PATCHES
        pkgconfig.diff
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        "-DTREE_SITTER_CLI=${CURRENT_HOST_INSTALLED_DIR}/tools/tree-sitter-cli/tree-sitter${VCPKG_HOST_EXECUTABLE_SUFFIX}"
        -DTREE_SITTER_REUSE_ALLOCATOR=ON
)
vcpkg_cmake_install()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
