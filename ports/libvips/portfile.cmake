vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libvips/libvips
    REF "v${VERSION}"
    SHA512 3ebb2b5fbe3d7ed35a1f4b591dacf0cfbea3e3f6a379051a86db20eaa26d50cc9b785562c62e4dbd29c4da7c93dd6469a3becb90808cbed258944481e7f2f316
    HEAD_REF master
)

function(z_append_meson_bool_option out_options option_name feature_name)
    if(feature_name IN_LIST FEATURES)
        list(APPEND "${out_options}" "-D${option_name}=true")
    else()
        list(APPEND "${out_options}" "-D${option_name}=false")
    endif()

    set("${out_options}" "${${out_options}}" PARENT_SCOPE)
endfunction()

function(z_append_meson_feature_option out_options option_name feature_name)
    if(feature_name IN_LIST FEATURES)
        list(APPEND "${out_options}" "-D${option_name}=enabled")
    else()
        list(APPEND "${out_options}" "-D${option_name}=disabled")
    endif()

    set("${out_options}" "${${out_options}}" PARENT_SCOPE)
endfunction()

# see ${SOURCE_PATH}/meson_options.txt
z_append_meson_bool_option(FEATURE_OPTIONS cplusplus cpp)

z_append_meson_feature_option(FEATURE_OPTIONS cfitsio cfitsio)
z_append_meson_feature_option(FEATURE_OPTIONS exif exif)
z_append_meson_feature_option(FEATURE_OPTIONS fontconfig fontconfig)
z_append_meson_feature_option(FEATURE_OPTIONS archive archive)
z_append_meson_feature_option(FEATURE_OPTIONS heif heif)
z_append_meson_feature_option(FEATURE_OPTIONS jpeg jpeg)
z_append_meson_feature_option(FEATURE_OPTIONS jpeg-xl jpeg-xl)
z_append_meson_feature_option(FEATURE_OPTIONS lcms lcms)
z_append_meson_feature_option(FEATURE_OPTIONS matio matio)
z_append_meson_feature_option(FEATURE_OPTIONS nifti nifti)
z_append_meson_feature_option(FEATURE_OPTIONS openexr openexr)
z_append_meson_feature_option(FEATURE_OPTIONS openjpeg openjpeg)
z_append_meson_feature_option(FEATURE_OPTIONS openslide openslide)
z_append_meson_feature_option(FEATURE_OPTIONS highway highway)
z_append_meson_feature_option(FEATURE_OPTIONS orc orc)
z_append_meson_feature_option(FEATURE_OPTIONS png png)
z_append_meson_feature_option(FEATURE_OPTIONS poppler poppler)
z_append_meson_feature_option(FEATURE_OPTIONS rsvg rsvg)
z_append_meson_feature_option(FEATURE_OPTIONS spng spng)
z_append_meson_feature_option(FEATURE_OPTIONS tiff tiff)
z_append_meson_feature_option(FEATURE_OPTIONS webp webp)
z_append_meson_feature_option(FEATURE_OPTIONS zlib zlib)

z_append_meson_bool_option(FEATURE_OPTIONS nsgif nsgif)
z_append_meson_bool_option(FEATURE_OPTIONS ppm ppm)
z_append_meson_bool_option(FEATURE_OPTIONS analyze analyze)
z_append_meson_bool_option(FEATURE_OPTIONS radiance radiance)

if("nifti" IN_LIST FEATURES)
    list(APPEND FEATURE_OPTIONS "-Dnifti-prefix-dir=${CURRENT_INSTALLED_DIR}")
endif()

vcpkg_configure_meson(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        -Dintrospection=disabled
        -Dexamples=false
)
vcpkg_install_meson()
vcpkg_fixup_pkgconfig()

vcpkg_copy_tools(TOOL_NAMES vips vipsedit vipsheader vipsthumbnail AUTO_CLEAN)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
