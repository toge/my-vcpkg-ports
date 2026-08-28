vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO wasm3/wasm3
    REF v${VERSION}
    SHA512 b9147df542d9b46cf8a20542829d9b5b9e81bfee498de957d6607c6b7aaeefbca404e1469a2c32bc0cac31dee2f0243b2c19f3d8353e535c2857bdb7d01188d2
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
