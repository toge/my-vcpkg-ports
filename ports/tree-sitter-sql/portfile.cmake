if(VCPKG_TARGET_IS_WINDOWS)
    vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO derekstride/tree-sitter-sql
    REF c2e1e08db1ea20dc23bdb8d228a81a8756e9c450
    SHA512 6bd2350eafe96901502c895cda809407108a7c14d4bcfedcbff55ec7bc8c897db27412246ebbc741bb6a465c38dbafe0815e2848c2794a05ed4b7f961f17f5b9
    HEAD_REF master
    PATCHES
        pkgconfig.diff
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        "-DTREE_SITTER_CLI=${CURRENT_HOST_INSTALLED_DIR}/tools/tree-sitter-cli/tree-sitter${VCPKG_HOST_EXECUTABLE_SUFFIX}"
#        -DTREE_SITTER_REUSE_ALLOCATOR=ON
)
vcpkg_cmake_install()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
