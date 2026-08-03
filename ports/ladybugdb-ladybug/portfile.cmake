vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO LadybugDB/ladybug
    REF v${VERSION}
    SHA512 f0485e851cbc19f9680dc0dd8a7c71e766cb3071a0b2b1555c7993d90b2198346214a57984ab7a5649f7e0543804b2175c2db550b631ab1eaa042cf5852cb62f
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
