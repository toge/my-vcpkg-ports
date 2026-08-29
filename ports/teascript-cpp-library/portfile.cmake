set(VCPKG_BUILD_TYPE release)  # Header-only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Florian-Thake/TeaScript-Cpp-Library
    REF v${VERSION}
    SHA512 3246c179cc1c1e6372dfc2ea11f332016190bebd3841bf35ce168838b35ec20d0107b60f6708300d032b1a0a17575ad60e53b425ffb3a97081d4d5859ff2fa11
    HEAD_REF main
    PATCHES
        devendoring.patch
)

file(REMOVE_RECURSE "${SOURCE_PATH}/include/teascript/thirdparty")

file(COPY ${SOURCE_PATH}/include/teascript DESTINATION "${CURRENT_PACKAGES_DIR}/include")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.TXT")
