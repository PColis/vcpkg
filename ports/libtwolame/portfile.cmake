include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO njh/twolame
    REF 45e78bd8be2daa5873e39bdf588c3f2070ef4d48#version 0.4.0
    SHA512 e24a13d7c678572d0086872ba2e25865152ab7d89937a438168048ca16c1bc135f97fde80ddce1fe102554403767648c52845982fff20e7f53b61438d59d627f
    HEAD_REF master
    PATCHES
		add_function.patch
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH}/libtwolame)
file(COPY ${SOURCE_PATH}/win32/configwin.h DESTINATION ${SOURCE_PATH}/libtwolame)
file(COPY ${SOURCE_PATH}/win32/winutil.h DESTINATION ${SOURCE_PATH}/libtwolame)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" TWOLAME_STATIC_BUILD)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/libtwolame
    PREFER_NINJA
	OPTIONS
		-DTWOLAME_STATIC_BUILD=${TWOLAME_STATIC_BUILD}
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/libtwolame RENAME copyright)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
