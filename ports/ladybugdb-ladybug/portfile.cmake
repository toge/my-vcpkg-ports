vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO LadybugDB/ladybug
    REF v${VERSION}
    SHA512 3c56530aee0ddbba4d6e27752eb99803bf50879063a4d171a6338a95bf0ab86156b308d4068af2aa217b9e70c86c9b4ef54b71abdb87e792e13036446f30c121
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
