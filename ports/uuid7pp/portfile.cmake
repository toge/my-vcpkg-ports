set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/uuid7pp
    REF 1e31c1f04752fdc655a38742e9936d27f912f2d7
    SHA512 d9dec62094b9a5a9064dee58c35d451962e225d441c3176bdfda037ad7a5854ed34bd4321102e763324145fa5b31a0927574237ccd742d5f7243f03bd33c3ceb
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
        -DBUILD_SAMPLE=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/uuid7pp")

# file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
