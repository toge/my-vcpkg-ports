vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO SouravRoy-ETL/slothdb
    REF v${VERSION}
    SHA512 f348b3fb3e9a3fb63e65fcfd17ebaeff211a5b696c176f6c488a1b7c3c11cfecbe22522b0c4da838d0ab987fc7bbfb983726ef7be8f6389f662091eb2bb11f4f
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
