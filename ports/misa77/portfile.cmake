vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO welcome-to-the-sunny-side/misa77
    REF "v${VERSION}"
    SHA512 5c3cd81b0bd5194e6175409260aa96082eacf67edeec6912c7e59af1bbbe9bb86d31eea6ea9587361a141c201e66e3429cca7bc2ecbda243d588b14ad7f770f1
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
