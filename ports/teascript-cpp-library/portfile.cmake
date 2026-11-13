set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Florian-Thake/TeaScript-Cpp-Library
    REF v${VERSION}
    SHA512 4e094fe4c0c771ef892e5e5035dcca763bdf3d0c7e6d713786e13812636999d5232bfb0a748dd2599560c11c1baae5e9ef2e9b044184e9eb676fbc98bc5c371e
    HEAD_REF main
    PATCHES
        devendoring.patch
)

file(REMOVE_RECURSE "${SOURCE_PATH}/include/teascript/thirdparty")

file(COPY ${SOURCE_PATH}/include/teascript DESTINATION "${CURRENT_PACKAGES_DIR}/include")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.TXT")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
