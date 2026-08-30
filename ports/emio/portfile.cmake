set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Viatorus/emio
    REF ${VERSION}
    SHA512 8065a7b9da86df46eaeadfe38d2fea25b33198eba0d95eef94c5a2d4ecda49ae98394a421e30029e1ecb281446e55b8ddbaaad496ad9ff8598b536804f988cb7
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "share/emio")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
