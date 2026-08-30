vcpkg_download_distfile(ARCHIVE
    URLS "https://www.agentpp.com/download/snmp++-${VERSION}.tar.gz"
    FILENAME "snmp++-${VERSION}.tar.gz"
    SHA512 c86983dd36f127dc69434b18ace7cb00fdd7300d43cfd446e75519bd1adb9745c74621ca78323fdce63d2b2b4d4f805c58325839ff1a8343da981bc67c6352d4
)

vcpkg_extract_source_archive(
    SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
    PATCHES
        fix-cmake.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DOPTION_SNMPv3=ON
        -DOPTION_IPv6=ON
        -DOPTION_THREADS=ON
        -DOPTION_NAMESPACE=ON
        -DOPTION_LOGGING=ON
        -DOPTION_OPENSSL=ON
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME snmp++ CONFIG_PATH lib/cmake/snmp++)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")

# Extract license from source file (Snmp++ has no separate LICENSE file)
file(READ "${SOURCE_PATH}/src/address.cpp" ADDRESS_CPP_CONTENT)
string(REGEX MATCH [[/\*=====.+=====\*/]] LICENSE_CONTENT "${ADDRESS_CPP_CONTENT}")
if(LICENSE_CONTENT STREQUAL "")
    # fallback: use first 100 lines of address.cpp header
    string(SUBSTRING "${ADDRESS_CPP_CONTENT}" 0 4000 LICENSE_CONTENT)
endif()
file(WRITE "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright" "${LICENSE_CONTENT}")
unset(ADDRESS_CPP_CONTENT)
unset(LICENSE_CONTENT)
