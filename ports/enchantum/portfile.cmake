vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ZXShady/enchantum
    REF ${VERSION}
    SHA512 f0eb25164bc6b9f0579267f03f2080615972b4a81ff2f9b0fa8c8621888b775e13e7c250895678e4a98bfccdbb38b5d3e137b3ac198cb6122f68ec015293d11b
    HEAD_REF main
)

set(VCPKG_BUILD_TYPE release)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
# Fix the upstream port bug: the generated targets file is installed under
# share/enchantum/cmake/ but enchantumConfig.cmake includes it via
# ${CMAKE_CURRENT_LIST_DIR}/enchantumTargets.cmake (i.e. share/enchantum/),
# which fails with "include could not find requested file".
# Also move the config files out of the top-level cmake/ dir.
vcpkg_cmake_config_fixup(CONFIG_PATH "cmake" DO_NOT_DELETE)
file(GLOB _targets_files "${CURRENT_PACKAGES_DIR}/share/enchantum/cmake/*")
foreach(_file IN LISTS _targets_files)
    get_filename_component(_name "${_file}" NAME)
    file(INSTALL "${_file}" DESTINATION "${CURRENT_PACKAGES_DIR}/share/enchantum")
    file(REMOVE "${_file}")
endforeach()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/share/enchantum/cmake")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
