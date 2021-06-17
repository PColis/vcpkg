# binary-only library

vcpkg_download_distfile(ARCHIVE
  URLS "https://www.audioscience.com/internet/download/sdk/asihpk_42019.7Z"
  FILENAME "asihpk_42019.7Z"
  SHA512 a3464b1575e76bc1c9b5e459b807d01b116c317bcf0241b3deb2550643b971ec5ea584525fadef06aabf8dbb507e07134e6ef8ba56c66ac54177c2947ca4a009
)

vcpkg_extract_source_archive_ex(
  OUT_SOURCE_PATH PACKAGE_PATH
  ARCHIVE ${ARCHIVE}
  NO_REMOVE_ONE_LEVEL
)

file(GLOB HEADER_FILES "${PACKAGE_PATH}/*.h" "${PACKAGE_PATH}/*.cs")
file(INSTALL ${HEADER_FILES} DESTINATION "${CURRENT_PACKAGES_DIR}/include/${PORT}")

if(VCPKG_TARGET_ARCHITECTURE EQUAL "x86")
  file(INSTALL "${PACKAGE_PATH}/asihpi32.lib"
               "${PACKAGE_PATH}/asihpiudp32.lib"
       DESTINATION "${CURRENT_PACKAGES_DIR}/lib")
  file(INSTALL "${PACKAGE_PATH}/asihpi32.lib"
               "${PACKAGE_PATH}/asihpiudp32.lib"
       DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib")
else()
  file(INSTALL "${PACKAGE_PATH}/asihpi64.lib"
               "${PACKAGE_PATH}/asihpiudp64.lib"
       DESTINATION "${CURRENT_PACKAGES_DIR}/lib")
  file(INSTALL "${PACKAGE_PATH}/asihpi64.lib"
               "${PACKAGE_PATH}/asihpiudp64.lib"
       DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib")
  if(NOT VCPKG_LIBRARY_LINKAGE STREQUAL static)
    file(INSTALL "${PACKAGE_PATH}/AsiHpiDotNet.dll"
         DESTINATION "${CURRENT_PACKAGES_DIR}/debug/bin")
  endif()
endif()
file(DOWNLOAD "https://www.audioscience.com/internet/download/sdk/SDKLicense.rtf" "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright")
file(INSTALL "${PACKAGE_PATH}/drvnotes.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME HISTORY)
file(INSTALL "${PACKAGE_PATH}/AsiHpiDotNet.pdf" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/FindAsihpi.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
