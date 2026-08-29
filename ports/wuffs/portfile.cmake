set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO google/wuffs
    REF v${VERSION}
    SHA512 a9313ecea49c2d7e003daac685ca9bdd114bf7e70ea14ec0f2d6049c3fae9c0b1861e37fce4b014ca738822558ab346a95d66f2cde6b8db45cdd6d1c46be4856
    HEAD_REF main
)

file(COPY "${SOURCE_PATH}/release/c/wuffs-v0.3.c" DESTINATION "${CURRENT_PACKAGES_DIR}/include")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
