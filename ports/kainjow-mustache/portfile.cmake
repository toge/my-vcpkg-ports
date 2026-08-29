vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO kainjow/Mustache
    REF 3f654942a70c46a775070d7a09ca7acfa3e205b7
    SHA512 d44b68b1e8f9326c5526d5402097903e0ff21bc2f3fb81cf0e13b85a7ef5e60e5306f7ce504d57546ce126ae2b04e9ec0825e22b81a10b8463a7c0c88f7473e5
    HEAD_REF master
)

# Upstream CMakeLists has no install() rules (just add_library INTERFACE),
# so we install the header manually and provide a minimal Config package.
file(INSTALL "${SOURCE_PATH}/mustache.hpp" DESTINATION "${CURRENT_PACKAGES_DIR}/include")
# Compatibility: also install under kainjow/ subdirectory for #include <kainjow/mustache.hpp>
file(INSTALL "${SOURCE_PATH}/mustache.hpp" DESTINATION "${CURRENT_PACKAGES_DIR}/include/kainjow")

# Generate Config.cmake for find_package(kainjow-mustache CONFIG)
include(CMakePackageConfigHelpers)
configure_package_config_file(
    "${CMAKE_CURRENT_LIST_DIR}/kainjow-mustache-config.cmake.in"
    "${CURRENT_PACKAGES_DIR}/share/kainjow-mustache/kainjow-mustache-config.cmake"
    INSTALL_DESTINATION "share/kainjow-mustache"
)
write_basic_package_version_file(
    "${CURRENT_PACKAGES_DIR}/share/kainjow-mustache/kainjow-mustache-config-version.cmake"
    VERSION "5.0.0"
    COMPATIBILITY AnyNewerVersion
)

# Provide `mustache` package name as well for `find_package(mustache CONFIG)`
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/share/mustache")
configure_package_config_file(
    "${CMAKE_CURRENT_LIST_DIR}/kainjow-mustache-config.cmake.in"
    "${CURRENT_PACKAGES_DIR}/share/mustache/mustache-config.cmake"
    INSTALL_DESTINATION "share/mustache"
)
file(COPY "${CURRENT_PACKAGES_DIR}/share/kainjow-mustache/kainjow-mustache-config-version.cmake"
     DESTINATION "${CURRENT_PACKAGES_DIR}/share/mustache")
file(RENAME "${CURRENT_PACKAGES_DIR}/share/mustache/kainjow-mustache-config-version.cmake"
            "${CURRENT_PACKAGES_DIR}/share/mustache/mustache-config-version.cmake")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
