vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/pcrepp
    REF 08d6a1aed911142b416ec4fd8da5285e8db76b34
    SHA512 bbc9db3f113622dc4c5268201cfe4ef67016d6b07ee5693ef105ab8be642c1a0e012e534b55899752d1d26a98c59dcb6b6891dddf7146d1c3f5593ff6887642a
    HEAD_REF main
)

vcpkg_replace_string("${SOURCE_PATH}/CMakeLists.txt"
    "configure_package_config_file("
    "write_basic_package_version_file(\"\${CMAKE_CURRENT_BINARY_DIR}/pcreppConfigVersion.cmake\" VERSION 0.1.0 COMPATIBILITY AnyNewerVersion)\nconfigure_package_config_file("
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DENABLE_TESTS=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME pcrepp CONFIG_PATH lib/cmake/pcrepp)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
