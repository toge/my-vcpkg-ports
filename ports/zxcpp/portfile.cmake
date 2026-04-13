set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/zxcpp
    REF 8bad29c754eb5f81b61ac6f6cdefb99337910903
    SHA512 0b9df06e275e71e54882413562f0bda81523129f3b136fee60615d1f890cc9ae2de94b0478105c212a8f9c5314af49707967cb42c97ca926e25e01c95f189299
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/zxcpp")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
