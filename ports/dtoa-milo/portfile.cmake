vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO miloyip/dtoa-benchmark
  REF bf1fb58ade01658c908a498679e47f0b4e89aff7
  SHA512 184e59d1a449cf96dae1dfcba3cb88fc83c3cb3ba016b7b422ad27f457294ba15196e66b0724e91441eff68937faa9d634ea8724eb3d7195039753f1f543b21a
  HEAD_REF master
  PATCHES fix-includes.patch
)

file(INSTALL "${SOURCE_PATH}/src/milo/dtoa_milo.h"
    DESTINATION "${CURRENT_PACKAGES_DIR}/include/${PORT}")

file(INSTALL "${SOURCE_PATH}/license.txt"
    DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
    RENAME copyright)
