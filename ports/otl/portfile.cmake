set(OTL_VERSION 40475)

vcpkg_download_distfile(ARCHIVE
    URLS "http://otl.sourceforge.net/otlv4_${OTL_VERSION}.zip"
    FILENAME "otlv4_${OTL_VERSION}-9485a0fe15a7.zip"
    SHA512 b4dee971458ba1e9027cf7cde5396ba7ae592f7730fcdb095b511f9c0721dc83b58ccd497e698aa23639eac773be0f0c0a0b37dbe01454d73f6c672ebcfa1f11
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    NO_REMOVE_ONE_LEVEL
)

file(INSTALL "${SOURCE_PATH}/otlv${OTL_VERSION}.h" 
    DESTINATION "${CURRENT_PACKAGES_DIR}/include/${PORT}" 
    RENAME otlv4.h)

file(READ "${SOURCE_PATH}/otlv${OTL_VERSION}.h" copyright_contents)
string(FIND "${copyright_contents}" "#ifndef OTL_H" start_of_source)
if(start_of_source EQUAL "-1")
    message(FATAL_ERROR "Could not find start of source; the header file has changed in a way that we cannot get the license text.")
endif()
string(SUBSTRING "${copyright_contents}" 0 "${start_of_source}" copyright_contents)
string(REGEX REPLACE "// ?" "" copyright_contents "${copyright_contents}")
string(REGEX REPLACE "=+\n" "" copyright_contents "${copyright_contents}")

file(WRITE
    "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright"
    "${copyright_contents}"
)
