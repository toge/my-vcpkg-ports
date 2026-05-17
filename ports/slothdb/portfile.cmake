vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO SouravRoy-ETL/slothdb
    REF v${VERSION}
    SHA512 04f313f3875ec9eb41fb09587c3c2cfb58f9a05337aaae0ec3720bac6d30c4bd842a5f1c6d84368e462bd33d7428fa481f7648b4b2e332c8df920d23e51dd1ce
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
