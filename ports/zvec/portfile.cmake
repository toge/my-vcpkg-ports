vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO alibaba/zvec
    REF v${VERSION}
    SHA512 2728b849c1c52a7cc44e49fe2f3f9ec9a8e8188943750d9a9c06f5badfd418bac0dce056ae41a3be89966fb9462ed8a3a9b15f87fcb938ff9206c747a3246c49
    HEAD_REF main
    PATCHES
        fix-add-library-macro-conflict.patch
        devendoring.patch
        fix-antlr4-13-compat.patch
        fix-diskann-libaio.patch
        fix-fastpfor-includes.patch
        fix-u8string.patch
        fix-rocksdb-unique-ptr.patch
        fix-wal-cstdint.patch
        disable-tests.patch
        unofficial-cmake-config.patch
)

vcpkg_from_github(
    OUT_SOURCE_PATH RABITQ_SOURCE_PATH
    REPO VectorDB-NTU/RaBitQ-Library
    REF 89480d88748cdee87c7b4cdd6194ce4b9ff250d8
    SHA512 74016824d7eba1131a25dec2df25989df47c0c3bec5879ad0725b41e928dbdaf9622b50e99870279282eba261d6e7a23e3259b28d28f219f687538c36c75e54a
    HEAD_REF main
)
file(RENAME "${RABITQ_SOURCE_PATH}" "${SOURCE_PATH}/thirdparty/RaBitQ-Library/RaBitQ-Library-0.1")

vcpkg_from_github(
    OUT_SOURCE_PATH LIMONP_SOURCE_PATH
    REPO yanyiwu/limonp
    REF v1.0.2
    SHA512 a56f749b86943283381ccfb01b3edfaf338dec4c34eb1bfdbe00e08b33bc36fa277bde3588e18d4752feedf534541a285d34a5b06041bd8c7b96930012e98814
    HEAD_REF master
)
file(RENAME "${LIMONP_SOURCE_PATH}" "${SOURCE_PATH}/thirdparty/limonp/limonp-v1.0.2")

vcpkg_from_github(
    OUT_SOURCE_PATH CPPJIEBA_SOURCE_PATH
    REPO yanyiwu/cppjieba
    REF v5.6.7
    SHA512 8543acb8e39875509c8f0eef1e054d6c7fe028ace047f181d358d46373f5ff4f7c7c766c0df9c0eb30cad90d2044ac2d651a3013c4effaabd2e7ac302e23d977
    HEAD_REF master
)
file(RENAME "${CPPJIEBA_SOURCE_PATH}" "${SOURCE_PATH}/thirdparty/cppjieba/cppjieba-5.6.7")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TOOLS=OFF
        -DCMAKE_CXX_STANDARD=20
        # requires std::partial_ordering, std::strong_ordering
        -DCMAKE_CXX_STANDARD_REQUIRED=ON
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(
    PACKAGE_NAME unofficial-zvec
    CONFIG_PATH share/unofficial-zvec
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share"
                    "${CURRENT_PACKAGES_DIR}/debug/include/include"
                    "${CURRENT_PACKAGES_DIR}/include/include"
                    "${CURRENT_PACKAGES_DIR}/debug/include"
)
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
