set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/bdfdrawpp
    REF a8888963ad4d64b309a6d2157476e2e39be1045b
    SHA512 f2448e1cae53e249241f97c62b2f74eb64d7297dbad25e1f2fd4ca37124cd7a786bbd8e70bb4c504fd6417dadd15b534e3165c06ec41bdbd75f6c75859229283
    HEAD_REF main
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
    zxc     ENABLE_ZXC
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/bdfdrawpp")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
