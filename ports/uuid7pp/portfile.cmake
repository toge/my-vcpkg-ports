set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/uuid7pp
    REF 3fbc16da6fdd0df2fc76af9a34996ff731247709
    SHA512 f194d92908f3974fc03c17451bef6015972bc16f2f26c025c27b2c5b0b6170e0028f8cc12b36870bec44525495142c15cca7cebb8295d67972141db20e97657f
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DENABLE_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/uuid7pp")

# file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
