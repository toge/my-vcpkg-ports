vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO micro-gl/nitro-gl
    REF 61bbff737b3de87d64c9e2bc3d36c86b764752d2
    SHA512 e7f070711e99448da9f860ab87a5d592c830c3508bdf8c2207766004631f8aa0d8ee7c2d126407f3c4371e99e0506743dc4e28093252e04b1f39dbce7773b887
    HEAD_REF main
)

vcpkg_replace_string("${SOURCE_PATH}/CMakeLists.txt" "add_subdirectory(examples)" "")

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME nitrogl CONFIG_PATH "share/nitrogl/cmake")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.MD")
