vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO SouravRoy-ETL/slothdb
    REF v${VERSION}
    SHA512 53044e4cde3a6c5c3d3b405b9b875b2aa4687718212f287dc888b6d865c2b5f0c559e78c33d3ef44673e0455875eb0f892f05ed7bb8abecc4f5a7fb317c5aa41
    HEAD_REF master
    PATCHES
        unofficial-cmake-config.patch
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        util   SLOTHDB_BUILD_SHELL
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DSLOTHDB_BUILD_TESTS=OFF
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(
    PACKAGE_NAME unofficial-slothdb
    CONFIG_PATH share/unofficial-slothdb
)

if("util" IN_LIST FEATURES)
   vcpkg_copy_tools(
        TOOL_NAMES
            slothdb
        AUTO_CLEAN
    )
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share"
                    "${CURRENT_PACKAGES_DIR}/debug/include"
)
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
