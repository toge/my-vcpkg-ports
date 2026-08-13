vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/pcrepp
    REF 8f5a288d2610ec08cb4ab05a90c56ee35aecca65
    SHA512 169aa6d4b4755c9d76fe047a0f0421de0795c6ca18269df158945e50bb68e1e3844f9d5e768c48c92048a6c57a9161144882fd41b0f6fef554f90d887af740a7
    HEAD_REF main
)

vcpkg_replace_string("${SOURCE_PATH}/CMakeLists.txt"
    "configure_package_config_file("
    "write_basic_package_version_file(\"\${CMAKE_CURRENT_BINARY_DIR}/pcreppConfigVersion.cmake\" VERSION 0.1.0 COMPATIBILITY AnyNewerVersion)\nconfigure_package_config_file("
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        ctre    WITH_CTRE
        glaze   WITH_GLAZE
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
        -DBUILD_BENCH=OFF
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME pcrepp CONFIG_PATH lib/cmake/pcrepp)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
