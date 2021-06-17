message(STATUS "Using VCPKG FindAsihpi")
set(ASIHPI_PREV_MODULE_PATH ${CMAKE_MODULE_PATH})
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

list(REMOVE_ITEM ARGS "NO_MODULE")
list(REMOVE_ITEM ARGS "CONFIG")
list(REMOVE_ITEM ARGS "MODULE")

_find_package(${ARGS})

set(CMAKE_MODULE_PATH ${ASIHPI_PREV_MODULE_PATH})
