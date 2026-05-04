vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/pcrepp
    REF 33168fe1c96925e28c194002e778bc5877a9b082
    SHA512 ac219c8d3575499f7b2c303a2cea310c13e8caa7a6cadfabe3b9c09b009c7382473540f34fcf6275ccec511d45a95d1e5ab07b36997acdf86140fe56f283af23
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
