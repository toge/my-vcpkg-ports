vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO alibaba/zvec
    REF v${VERSION}
    SHA512 4f65de2346961834510b9d9eb7bacf7fd4ab6ccbb54f6e102a4eae32139d29d803c7aeeecfe185e1bcc69fcd3aa335fc009c4ffc702cda987a73f6bc0704f3be
    HEAD_REF main
    PATCHES
        fix-add-library-macro-conflict.patch
        devendoring.patch
        fix-antlr4-13-compat.patch
        unofficial-cmake-config.patch
        fix-u8string.patch
)

vcpkg_from_github(
    OUT_SOURCE_PATH RABITQ_SOURCE_PATH
    REPO VectorDB-NTU/RaBitQ-Library
    REF 89480d88748cdee87c7b4cdd6194ce4b9ff250d8
    SHA512 74016824d7eba1131a25dec2df25989df47c0c3bec5879ad0725b41e928dbdaf9622b50e99870279282eba261d6e7a23e3259b28d28f219f687538c36c75e54a
    HEAD_REF main
)
file(RENAME "${RABITQ_SOURCE_PATH}" "${SOURCE_PATH}/thirdparty/RaBitQ-Library/RaBitQ-Library-0.1")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TOOLS=OFF
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(
    PACKAGE_NAME unofficial-zvec
    CONFIG_PATH share/unofficial-zvec
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share"
                    "${CURRENT_PACKAGES_DIR}/debug/include"
)
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
