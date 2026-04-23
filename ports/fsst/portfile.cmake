vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cwida/fsst
    REF e638d4cf8c26129d73c242a4127b42b975de5b63
    SHA512 e28703c0984cfd87db121e12e7d9e615c4e402ecbea01249fd6d7f88c3cdee2a4932866e744e86c4fea4f3b2fbfc5908a468c6c1435af9eaff34264eed347f01
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
