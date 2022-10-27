vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Haivision/srt
    REF v1.4.4
    SHA512 0D51E0EF73F4AA7EB284288CDBBD75B1C161969C2C2FED3A6D4E13A931341CA41DFCF2D6C1B9728F72B43454A9FDE3764DA67A27AF9F0C99A6818682E4F4D4BA
    HEAD_REF master
    PATCHES
		fix-dependency-install.patch
		rename_md5_init.patch
)

if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    set(BUILD_DYNAMIC ON)
    set(BUILD_STATIC OFF)
else()
    set(BUILD_DYNAMIC OFF)
    set(BUILD_STATIC ON)
endif()

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        tool ENABLE_APPS
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS ${FEATURE_OPTIONS}
        -DENABLE_SHARED=${BUILD_DYNAMIC}
        -DENABLE_STATIC=${BUILD_STATIC}
        -DENABLE_UNITTESTS=OFF
        -DUSE_OPENSSL_PC=OFF
        -DENABLE_STDCXX_SYNC=ON
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
