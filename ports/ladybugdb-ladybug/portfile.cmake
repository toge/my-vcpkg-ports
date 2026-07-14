vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO LadybugDB/ladybug
    REF v${VERSION}
    SHA512 902a228471bae452ffa96decb3e90aadbfca78c0a8301313c6c367feb665948db814ace663c22413d3b056acc52fcc758f27c59bb68743716cd0dd9e88b2d958
    HEAD_REF master
    PATCHES
        unofficial-cmake-config.patch
        include-cstdint.patch
        fix-alp-encode-avx512.patch
        fix-init-segment.patch
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        shell BUILD_SHELL
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        -DBUILD_SINGLE_FILE_HEADER=OFF
        -DBUILD_TESTS=FALSE
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(
    PACKAGE_NAME unofficial-ladybugdb-ladybug
    CONFIG_PATH share/unofficial-ladybugdb-ladybug
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
