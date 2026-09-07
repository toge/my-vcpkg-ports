set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/yase-json
    REF a9b020439fb48a8983ebb2d2eea5e7b501dda395
    SHA512 cec1c3075bb13e3f9c48abe2c6dadd359bfd2d8858fd13a7f3236df142eb3a3e2a3c78ed0d1b9827070e96d32c1bdce2f50c8b307dd144bcc8a5f6d4b466973b
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/yase-json)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
