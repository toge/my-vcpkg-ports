vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/openrasterpp
    REF 6c7ae56e156bf288f88a112b2ac160bdab11327e
    SHA512 9324c154861a6724d48f10f7b8db70e0ef6eef845a0ea9f23d98e44259709102ba931a4bacd24cb5c5877e0624892e7ce6e61d3f567bb498a84077a69adb5be1
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
