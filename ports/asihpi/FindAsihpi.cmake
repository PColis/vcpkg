include(${CMAKE_ROOT}/Modules/FindPackageHandleStandardArgs.cmake)

set(ASIHPI_VERSION "4.20.19")

if(NOT ASIHPI_INCLUDE_DIR)
  find_path(ASIHPI_INCLUDE_DIR
            NAMES hpi.h
            PATH_SUFFIXES asihpi)
endif()

find_package_handle_standard_args(asihpi
                                  REQUIRED_VARS ASIHPI_INCLUDE_DIR
                                  VERSION_VAR   ASIHPI_VERSION)
mark_as_advanced(ASIHPI_INCLUDE_DIR)

string(REPLACE "/include/asihpi" "/lib"       asihpi_LIB_DIR       ${ASIHPI_INCLUDE_DIR})
string(REPLACE "/include/asihpi" "/bin"       asihpi_BIN_DIR       ${ASIHPI_INCLUDE_DIR})
string(REPLACE "/include/asihpi" "/debug/lib" asihpi_DEBUG_LIB_DIR ${ASIHPI_INCLUDE_DIR})
string(REPLACE "/include/asihpi" "/debug/bin" asihpi_DEBUG_BIN_DIR ${ASIHPI_INCLUDE_DIR})

if(ASIHPI_FOUND AND NOT TARGET AudioScience::HPI)
  if(EXISTS "${asihpi_LIB_DIR}/asihpi32.lib")
    set(ASIHPI_RELEASE_LIB "${asihpi_LIB_DIR}/asihpi32.lib")
    set(ASIHPI_DEBUG_LIB   "${asihpi_DEBUG_LIB_DIR}/asihpi32.lib")
  else()
    set(ASIHPI_RELEASE_LIB "${asihpi_LIB_DIR}/asihpi64.lib")
    set(ASIHPI_DEBUG_LIB   "${asihpi_DEBUG_LIB_DIR}/asihpi64.lib")
  endif()

  add_library(AudioScience::HPI STATIC IMPORTED)
  set_target_properties(AudioScience::HPI PROPERTIES
#    IMPORTED_IMPLIB_RELEASE         "${ASIHPI_RELEASE_LIB}"
#    IMPORTED_IMPLIB_DEBUG           "${ASIHPI_DEBUG_LIB}"
    IMPORTED_LOCATION_RELEASE       "${ASIHPI_RELEASE_LIB}"
    IMPORTED_LOCATION_DEBUG         "${ASIHPI_DEBUG_LIB}"
    INTERFACE_INCLUDE_DIRECTORIES   "${ASIHPI_INCLUDE_DIR}"
    IMPORTED_CONFIGURATIONS         "Debug;Release")
endif()

if(ASIHPI_FOUND AND NOT TARGET AudioScience::HPIudp)
  if(EXISTS "${asihpi_LIB_DIR}/asihpiudp32.lib")
    set(ASIHPIUDP_RELEASE_LIB "${asihpi_LIB_DIR}/asihpiudp32.lib")
    set(ASIHPIUDP_DEBUG_LIB   "${asihpi_DEBUG_LIB_DIR}/asihpiudp32.lib")
  else()
    set(ASIHPIUDP_RELEASE_LIB "${asihpi_LIB_DIR}/asihpiudp64.lib")
    set(ASIHPIUDP_DEBUG_LIB   "${asihpi_DEBUG_LIB_DIR}/asihpiudp64.lib")
  endif()

  add_library(AudioScience::HPIudp STATIC IMPORTED)
  set_target_properties(AudioScience::HPIudp PROPERTIES
#    IMPORTED_IMPLIB_RELEASE         "${ASIHPIUDP_RELEASE_LIB}"
#    IMPORTED_IMPLIB_DEBUG           "${ASIHPIUDP_DEBUG_LIB}"
    IMPORTED_LOCATION_RELEASE       "${ASIHPIUDP_RELEASE_LIB}"
    IMPORTED_LOCATION_DEBUG         "${ASIHPIUDP_DEBUG_LIB}"
    INTERFACE_INCLUDE_DIRECTORIES   "${ASIHPI_INCLUDE_DIR}"
    IMPORTED_CONFIGURATIONS         "Debug;Release")
endif()

if(ASIHPI_FOUND AND TARGET AudioScience::HPI AND TARGET AudioScience::HPIudp)
  # Put all together
  add_library(AudioScience INTERFACE IMPORTED)
  set_target_properties(AudioScience PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES   "${ASIHPI_INCLUDE_DIR}"
    INTERFACE_LINK_LIBRARIES        "AudioScience::HPI;AudioScience::HPIudp"
    IMPORTED_CONFIGURATIONS         "Debug;Release")
endif()
