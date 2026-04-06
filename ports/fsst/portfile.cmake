vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cwida/fsst
    REF e512cedc4634f7342f6095288d00054a20f1afa9
    SHA512 89a19f5867186b6cf448758d3a4df47fe0c26e61231af37860372007911d38153a7dd296e97792f5e7b3d0dd792c8dbc4dc373b4ef14385034bc3bfc3fe3963c
    HEAD_REF master
    PATCHES
        fix-fsst12-symbol-pointer-type.patch
        unofficial-cmake-config.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(
    PACKAGE_NAME unofficial-fsst
    CONFIG_PATH share/unofficial-fsst
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share"
                    "${CURRENT_PACKAGES_DIR}/debug/include"
)
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
