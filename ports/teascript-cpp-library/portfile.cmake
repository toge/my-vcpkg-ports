set(VCPKG_BUILD_TYPE release)  # Header-only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Florian-Thake/TeaScript-Cpp-Library
    REF v${VERSION}
    SHA512 d340229393d558b2ba140729a26cd2145fec6fb91a8f2e95043b07765444308d1c03311fb7ffa3c51a7d3d7b9852f5a9198281ff824ab6c309dfde67f33b5a03
    HEAD_REF main
    PATCHES
        devendoring.patch
)

file(REMOVE_RECURSE "${SOURCE_PATH}/include/teascript/thirdparty")

file(COPY ${SOURCE_PATH}/include/teascript DESTINATION "${CURRENT_PACKAGES_DIR}/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.TXT")
