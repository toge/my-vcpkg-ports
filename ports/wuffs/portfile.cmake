set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO google/wuffs
    REF v${VERSION}
    SHA512 413d86137b30bcb4a73c25e3e68beccb7a46d735da58a6027ac64e42da04e552cb49e3d923e657ccbf9dba0e6253eedde913b2a7a46d183e631ec573b6258f7f
    HEAD_REF main
)

file(COPY "${SOURCE_PATH}/release/c/wuffs-v0.3.c" DESTINATION "${CURRENT_PACKAGES_DIR}/include")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
