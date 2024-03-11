if(NOT TARGET_TRIPLET MATCHES "x64-windows-mfc-static")
  message(FATAL_ERROR "*** Only the x64-windows-mfc-static triplet supported ***")
endif(NOT TARGET_TRIPLET MATCHES "x64-windows-mfc-static")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
file(COPY ${VCPKG_ROOT_DIR}/ports/${PORT}/${PORT}Config.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT}/)

file(WRITE  "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" "The package ${PORT} provides CMake targets:\n")
file(APPEND "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" "    find_package(${PORT} CONFIG REQUIRED)\n")
file(APPEND "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" "    target_link_libraries(main Zenon::${PORT})\n")
file(WRITE  "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright" "(c) Zenon-Media GmbH")
