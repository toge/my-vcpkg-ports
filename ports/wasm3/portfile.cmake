vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO wasm3/wasm3
    REF 8b321c49a389423e89f6b6ef41cc518e4fc407d6
    SHA512 8da7539a78659d3991340dc2a91e572e6d96d8d7188bf15f369f4d6bb80d25932c5ce96fdd34eb91172ec27ecae103c1a565f48cf7282c178207087a47285351
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_WASI=simple
)

vcpkg_cmake_install()
vcpkg_copy_tools(TOOL_NAMES wasm3 AUTO_CLEAN)

file(GLOB WASM3_HEADERS "${SOURCE_PATH}/source/*.h")
file(COPY ${WASM3_HEADERS} DESTINATION "${CURRENT_PACKAGES_DIR}/include")

file(GLOB WASM3_LIB_RELEASE
    "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/source/libm3*.a"
    "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/source/m3*.lib"
)
if(NOT WASM3_LIB_RELEASE)
    message(FATAL_ERROR "release libm3 not found in ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/source")
endif()
file(COPY ${WASM3_LIB_RELEASE} DESTINATION "${CURRENT_PACKAGES_DIR}/lib")

file(GLOB WASM3_LIB_DEBUG
    "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/source/libm3*.a"
    "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/source/m3*.lib"
)
if(NOT WASM3_LIB_DEBUG)
    message(WARNING "debug libm3 not found; skipping debug library")
endif()
file(COPY ${WASM3_LIB_DEBUG} DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib")

configure_file("${CMAKE_CURRENT_LIST_DIR}/Config.cmake.in"
    "${CURRENT_PACKAGES_DIR}/share/unofficial-wasm3/unofficial-wasm3Config.cmake" @ONLY)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
