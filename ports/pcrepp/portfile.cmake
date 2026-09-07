vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/pcrepp
    REF 613b73f3801cdddcb84e73aec767a3a4f9f578d0
    SHA512 50468769c1a7d1d074cb23a4f6c64c87f93c2976642a374f4ebfa7379ab49e2e33bc63907ce4996cd19568913b19aea358d695642d4a81f13a6f710f42eddcc7
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
