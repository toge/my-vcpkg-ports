set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/mojitonpp
    REF d06e3c3f7a4bc781acde08af9b5a95259d789cd2
    SHA512 b8648b18b814e19b24d59b5e5cb1aae6a2697e46dfafb63296577276a4111cd0a0df7a79940dab569106e1ae227fa16a8286fd35c1ff5d3c2188f5dfd353eadb
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/mojitonpp")

vcpkg_copy_tools(
    TOOL_NAMES sequence_detector
    AUTO_CLEAN
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
