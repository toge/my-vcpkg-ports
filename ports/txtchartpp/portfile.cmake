set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/txtchartpp
    REF b2af6c2ffd14298924024f2306eaf767de622cb1
    SHA512 63779b80e09f9e47d24940a4a423e4c13a87a2fe4a8e78941607abd6dc113cbc1152be8e05e7192892bd3819e79fca60959bf466d49d17dcca93d22b3ae8aa42
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/txtchartpp")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
