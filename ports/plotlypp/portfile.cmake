set(VCPKG_BUILD_TYPE release)  # Header-only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO jimmyorourke/plotlypp
    REF b786c47750d0e8ee2eeb340fcb86a8fa082d19ff
    SHA512 db7a41ea9b2cf552d65719bc78a8cb0fae4e7bac5c28cbc785c4966fc4179f5823af87bc4825eeb5b986d6c1f477a64ac83b4760be6e2ddfddb2115e8862e5b8
    HEAD_REF main
)

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DPLOTLYPP_BUILD_EXAMPLES=OFF
)
vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/${PORT})

# remove empty lib and debug/lib directories (and duplicate files from debug/include)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
