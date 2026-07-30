vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO welcome-to-the-sunny-side/misa77
    REF "v${VERSION}"
    SHA512 a5e68121e55e831853fe06f98cd0da4e39064ec3a1001a9c2de4cb7f9ad007d7cce91a6109160c0a072bb99ce69534f2f6c65d8d3e6ac9387db151f183dd457e
    HEAD_REF main
    PATCHES
        install.patch
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        cli MISA77_BUILD_CLI
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        -DMISA77_BUILD_TESTS=OFF
)

vcpkg_cmake_install()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/misa77)
vcpkg_copy_pdbs()
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
