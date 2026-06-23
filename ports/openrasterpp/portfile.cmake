vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/openrasterpp
    REF 695803a9bdf95159ea6c14bcd434961f60ba89ac
    SHA512 8648d591dae1359dbe3fa72a941ed385d08c023bd2482d491f900ea29ae3ac38d057c09dfd6697a9c321c73714fa4a0f3272e9c45f67a1c061733abf073be34d
    HEAD_REF main
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        loadpng OPENRASTERPP_ENABLE_LODEPNG
        libspng OPENRASTERPP_ENABLE_LIBSPNG
        libpng  OPENRASTERPP_ENABLE_LIBPNG
        stb     OPENRASTERPP_ENABLE_STB
        fpng    OPENRASTERPP_ENABLE_FPNG
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/openrasterpp")

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
