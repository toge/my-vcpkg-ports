set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/xlsxwriterpp
    REF fe0adba3566e8fd9c4733e95c1ea44cf41a18767
    SHA512 8a31cf6ad203c7f3ff2c2fcee4ba5114a6074cfd0b3f3ff7978cb5f6b832f03f0fcb430d0a5de38bb44ec355435429d381e44ef5409d9d376425ecea9d3ee353
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
        -DBUILD_EXAMPLE=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/xlsxwriterpp")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
