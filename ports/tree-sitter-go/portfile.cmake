if(VCPKG_TARGET_IS_WINDOWS)
    # ponytail: tree-sitter parsers use static linkage on Windows (upstream lacks DLL export)
    vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO tree-sitter/tree-sitter-go
    REF v${VERSION}
    SHA512 27690315ffa8a5834a96bb0f8654afe148eb495c20fb1ff8db790422203a0573f866254b38793588cbcc570c9c2fb7d628396ffed88529c7f70fd45f159e6b48
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        "-DTREE_SITTER_CLI=${CURRENT_HOST_INSTALLED_DIR}/tools/tree-sitter-cli/tree-sitter${VCPKG_HOST_EXECUTABLE_SUFFIX}"
)
vcpkg_cmake_install()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
