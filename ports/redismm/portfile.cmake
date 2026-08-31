set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/redismm
    REF 23cf3d07dc59ab454f5ca851c033db72d74ed14d
    SHA512 547606793f7acabbeb4c136c2f874ef421fb9ec92fa323ec82af924fcce7654c83bfc93f7bfbeb5ff12393306cb0a89022bc6a85bfec362b42d41cf72c2aed3f
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/redismm")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
