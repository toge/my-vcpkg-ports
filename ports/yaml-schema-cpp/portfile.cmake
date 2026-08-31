vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO joanvallve/yaml-schema-cpp
    REF ef8c4ae80c00dc822a95c8f26db1f9146f9092e4
    SHA512 ef9cfce968447bf34b8fc45e37472f09aa74e9fe7e3bc3f0f63e2298ed520b94aa0a03f6022ab371af428e9526745d23172d2ac64b21f7cc4d732746eb8ba1b6
    HEAD_REF main
    PATCHES
        remove-root-dir-for-tests.patch
        fix-windows-build.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DCMAKE_CXX_STANDARD=17
        -DBUILD_TESTS=OFF
)
vcpkg_cmake_install()

vcpkg_cmake_config_fixup(
    CONFIG_PATH "lib/cmake/yaml-schema-cpp"
)
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share"
                    "${CURRENT_PACKAGES_DIR}/debug/include"
)
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
