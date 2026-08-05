# Upstream (https://github.com/501urchin/tama) ships no LICENSE file, so the
# standard copyright check cannot be satisfied.
set(VCPKG_POLICY_SKIP_COPYRIGHT_CHECK enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO 501urchin/tama
    REF v${VERSION}
    SHA512 8a2c8c31376fbb5d9ef833a3cfcdd7d0458b47b1e3730cde4b096b4827fd235ad6baddd3d904d0eb45646ae3c0780ec563b0c08bd388b98e0abf8e73f84adb26
    HEAD_REF main
    PATCHES
        add-install-rules.patch
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/tamaConfig.cmake.in" DESTINATION "${SOURCE_PATH}/cmake")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DTAMA_BUILD_TESTS=OFF
        -DTAMA_RUN_BUILD=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/tama" PACKAGE_NAME tama)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include"
                    "${CURRENT_PACKAGES_DIR}/debug/share")
