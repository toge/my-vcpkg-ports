vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/pcrepp
    REF a70454ba53417b6da513a4cb7f84f74f35547bc5
    SHA512 81856500d06d96c35a59bc040b42456017fdd0f90eb74ed88b806cf9dcd84b12e9884b04986d952e78a4e35cc5cdfeaf40d59fe244d4fc9cd809bbf38b717fa5
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
