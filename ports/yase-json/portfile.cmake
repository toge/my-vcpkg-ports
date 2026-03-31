vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/yase-json
    REF 1d03584e7e247f01bba89885f12f97b4d53663a4
    SHA512 1e921a5339c95aa551e71695ad4488cd5e02a058e3c7993ba73be8382936f3ab8924bc2d9254d80b00f3eecafab209803d370ad99e95cd831ccfe7f327257a91
    HEAD_REF main
)

set(VCPKG_BUILD_TYPE release) # header-only port

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/yase-json)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
