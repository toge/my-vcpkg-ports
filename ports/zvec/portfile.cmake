vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO alibaba/zvec
    REF v${VERSION}
    SHA512 27c33959910ffe4b18237d0c28191a711335a5d0f406e5dbbe9d54d5e6412712412ac30d9584a96ff978d5acad40f9b4f965799210505b7cd1d502bd879dca73
    HEAD_REF main
    PATCHES
        fix-add-library-macro-conflict.patch
        devendoring.patch
        antlr4-13-regen.patch
        fix-fastpfor-includes.patch
        fix-u8string.patch
        fix-rocksdb-unique-ptr.patch
        fix-wal-cstdint.patch
        unofficial-cmake-config.patch
        install-snowball.patch
        fix-glog-0.7-api.patch
)

vcpkg_from_github(
    OUT_SOURCE_PATH RABITQ_SOURCE_PATH
    REPO VectorDB-NTU/RaBitQ-Library
    REF 540242ea0a68926f1b827bf1f9add844f07a427b
    SHA512 d0a2f1f85e83037679a89e9102ab0ea0d4170811f9fb00b65d9f22f9f3e1242ee121cf5a493b91e7afefe6ffad194fd01551f26e12d1c01cdacf64ed23a99dd7
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

vcpkg_from_github(
    OUT_SOURCE_PATH SNOWBALL_SOURCE_PATH
    REPO snowballstem/snowball
    REF v3.1.1
    SHA512 47a33f6319a728238b93b344a29c49b9aeb76bc8202b891da8134660be97d256e35980a25e557637c74fa6a8aff00b7e2d8e406d52b03233b71644989e4be9ac
    HEAD_REF master
)
file(REMOVE_RECURSE "${SOURCE_PATH}/thirdparty/snowball/snowball-3.1.1")
file(RENAME "${SNOWBALL_SOURCE_PATH}" "${SOURCE_PATH}/thirdparty/snowball/snowball-3.1.1")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TOOLS=OFF
        -DCMAKE_CXX_STANDARD=20
        # requires std::partial_ordering, std::strong_ordering
        -DCMAKE_CXX_STANDARD_REQUIRED=ON
        # ponytail: linking the all-in-one shared libzvec.so fails with
        # "ld.bfd: failed to set dynamic section sizes: bad value" (too many
        # exported symbols for the dbg/rel dynamic section). Static libs link
        # fine and are all the study project needs.
        -DBUILD_ZVEC_SHARED=OFF
        -DBUILD_ZVEC_AILEGO_SHARED=OFF
        -DBUILD_ZVEC_CORE_SHARED=OFF
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

vcpkg_install_copyright(
    FILE_LIST
        "${SOURCE_PATH}/LICENSE"
        "${SOURCE_PATH}/thirdparty/snowball/snowball-3.1.1/COPYING"
)
