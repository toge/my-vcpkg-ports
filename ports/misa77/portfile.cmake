vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO welcome-to-the-sunny-side/misa77
    REF "v${VERSION}"
    SHA512 3a081407b4078b845ccd848ea456b7f9dd0512eada3527e5f3815752af906d6c80b7cae9b389f5df5c149ec1cf23a25c786770dfb98ab3927ba80ce23318c3b5
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
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/misa77)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
vcpkg_copy_pdbs()
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
