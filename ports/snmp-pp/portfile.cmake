vcpkg_download_distfile(ARCHIVE
    URLS "https://www.agentpp.com/download/snmp++-${VERSION}.tar.gz"
    FILENAME "snmp++-${VERSION}.tar.gz"
    SHA512 9f7290b946ff7fa4f9cebd10cfa57cdb60cb8895dc10db56aa31a03b853c0aee033f13b924ce67d880b3bd8009545149aeb1430423b3bbb64b6b256766bb3863
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
