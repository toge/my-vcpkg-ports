vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO richgel999/fpng
    REF 925796543b9d26b8edfcdcecd94c1dac280f29fc
    SHA512 4d4f87d23fc37f66a2f3492678f99f0eb5c9ece39b0d51ad88b5d30a31490ca899fba8c2563f06ce3c7683e7b75c96f85f10da3ecf077e647edba2cbe55b7bd3
    HEAD_REF main
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")
file(COPY "${CMAKE_CURRENT_LIST_DIR}/unofficial-fpngConfig.cmake.in" DESTINATION "${SOURCE_PATH}")

vcpkg_cmake_configure(SOURCE_PATH ${SOURCE_PATH}
                      OPTIONS
                      -DPROJECT_VERSION_STRING=${VERSION})
vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME unofficial-fpng CONFIG_PATH "lib/cmake/unofficial-fpng")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")

# Unlicense is embedded in README; generate copyright file from it
file(READ "${SOURCE_PATH}/README.md" _fpng_readme)
string(REGEX MATCH "Unlicense[^\n]*\n[^\n]*" _fpng_license "${_fpng_readme}")
if(_fpng_license STREQUAL "")
    set(_fpng_license "Unlicense - public domain")
endif()
file(WRITE "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright" "${_fpng_license}\nSee https://unlicense.org/ for details.\n")
unset(_fpng_readme)
unset(_fpng_license)
