vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO welcome-to-the-sunny-side/misa77
    REF "v${VERSION}"
    SHA512 88f49f4183fb586ba5f91de4372e966477ee692e6263378c31ce4f6c93a8ea96bfd3df3140c29e4d6f4fe4ccca01dea11c1074de3f3a51744508581d1f683984
    HEAD_REF main
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
