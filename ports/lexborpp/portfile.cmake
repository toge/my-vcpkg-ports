set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/lexborpp
    REF 3dfc4c7ddefca25b9ece6260801ff6fbb8e57a11
    SHA512 c7dec526dbaf15ce21203cfe4a6dde1a1854304c00a14804c99c21a4da0c46a5cf40cddbc3d4b7e22ad25e8d4e8480a6cf86fc08a2b966a0e3709af3f07565f0
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/lexborpp")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
