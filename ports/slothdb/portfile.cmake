vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO SouravRoy-ETL/slothdb
    REF v${VERSION}
    SHA512 e704435ef8b47d811904293a868a415f05e58c47014ceb73803aa780d51f922cb7a620076cbab66541fd65427ac3601acb8c26702100fe459d698e8e8a0dbb18
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
