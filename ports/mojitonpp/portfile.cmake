set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/mojitonpp
    REF f213234c73d1952065aca2fb3d65e8957938a01d
    SHA512 f0f53d1e55c1f19ac438f11bbde4853f6a8bfdfeedb0bb391a7d7c2522c0c55f3f292668d18b39b7319a9dd4ccf80cf9c4aaccbca77b649d155d74ea1a0587ea
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/mojitonpp")

vcpkg_copy_tools(
    TOOL_NAMES sequence_detector
    AUTO_CLEAN
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
