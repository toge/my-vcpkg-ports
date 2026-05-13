vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/openrasterpp
    REF 2aaca5cb0d7bd74cce6ee542801a94d189bf7625
    SHA512 3fbc6a1c9f320edc2e031df78770f47dd5bd9a2bda3ef9da830ac379a4f64c68e7594cbc84e6d373a8e5977ca83aad0096f3675629bc14f64726b1df686e55b9
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
        -DENABLE_TESTS=OFF
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/openrasterpp")

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
