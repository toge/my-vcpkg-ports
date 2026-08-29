if(VCPKG_TARGET_IS_WINDOWS)
    # ponytail: tree-sitter parsers use static linkage on Windows (upstream lacks DLL export)
    vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO uyha/tree-sitter-cmake
    REF "v${VERSION}"
    SHA512 854f28babe23516dbba8dc74d32fb667f2c7019c92db6ced2e4b49f4ff39f54ad0dd2cb6c908e9e686b2d69bca38033d2f8cf843a2018470d53b40871d20af0d
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
