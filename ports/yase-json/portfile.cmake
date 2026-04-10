vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/yase-json
    REF be9826ca3339a1230000c70cb94c2b10ded1c65d
    SHA512 9426f5faa70e039e9f7fb2c47bae4c939ab3d2d1bcc628e7c0044008bd31527c98772c9965f61ebb819266aed4fc583e0e7ccd194b55424d00ed8d900a27d102
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
