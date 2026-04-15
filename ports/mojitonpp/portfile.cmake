set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/mojitonpp
    REF 1e16cc6ccd1254b8e34ddc9033df47496441102e
    SHA512 77bf3e05570178de5cb278f564db2bfec426395fdd536fb1979bf5e56ce9b462fb4779076173d662379831117760f3f4f7f47557c1b8a0c9468ddeb93e29b3c9
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/mojitonpp")

vcpkg_copy_tools(
    TOOL_NAMES sequence_detector
    AUTO_CLEAN
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
