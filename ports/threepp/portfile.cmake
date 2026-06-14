vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO markaren/threepp
    REF "${VERSION}"
    SHA512 0b159384e222fd8a4cd89c3fe4f62d6d8a326bf82b1c081de58c5a90b9983f25598a6434dfc832964892885072046e35b39ba39d87e2d102534eb47ab951851d
    HEAD_REF master
)

# Use system earcut-hpp instead of bundled one
vcpkg_replace_string(
    "${SOURCE_PATH}/src/threepp/extras/ShapeUtils.cpp"
    "#include \"external/earcut/earcut.hpp\""
    "#include <mapbox/earcut.hpp>"
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        external-glfw THREEPP_USE_EXTERNAL_GLFW
        vulkan       THREEPP_WITH_VULKAN
        physx        THREEPP_FETCH_PHYSX
        assimp       THREEPP_FETCH_ASSIMP
)

# threepp uses Catch2 for tests; disable them for port builds.
# It also fetches threepp_data (assets) only when examples/tests are on.
list(APPEND FEATURE_OPTIONS
    -DTHREEPP_BUILD_EXAMPLES=OFF
    -DTHREEPP_BUILD_TESTS=OFF
    -DTHREEPP_BUILD_EXAMPLE_PROJECTS=OFF
    -DTHREEPP_TREAT_WARNINGS_AS_ERRORS=OFF
)

# FBX/USD loaders pull in external deps (OpenFBX / tinyusdz) via FetchContent.
# Leave them off unless explicitly requested by a downstream feature later.
list(APPEND FEATURE_OPTIONS
    -DTHREEPP_WITH_FBX=OFF
    -DTHREEPP_WITH_USD=OFF
)

# WGPU backend requires wgpu-native; keep off for the basic port.
list(APPEND FEATURE_OPTIONS
    -DTHREEPP_WITH_WGPU=OFF
)

# Audio is on by default; keep it unless the platform can't support it.
if(NOT VCPKG_TARGET_IS_EMSCRIPTEN)
    list(APPEND FEATURE_OPTIONS -DTHREEPP_WITH_AUDIO=ON)
else()
    list(APPEND FEATURE_OPTIONS -DTHREEPP_WITH_AUDIO=OFF)
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()

# vcpkg_cmake_config_fixup(CONFIG_PATH "${CMAKE_INSTALL_DATADIR}/threepp")
vcpkg_cmake_config_fixup()

# Remove debug/include and tools if present
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/share/threepp/cmake")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
