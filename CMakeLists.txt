cmake_minimum_required(VERSION 3.14.0)

project(mhm_pydist_proj)
set(MHM_BUILD_VERSION "develop" CACHE STRING "Used mhm version.")
set(MHM_BUILD_TYPE "Release" CACHE STRING "Used mhm build type.")
option(MHM_BUILD_PARALLEL "mHM OpenMP support." OFF)
include(ExternalProject)
ExternalProject_add(mhm
  GIT_REPOSITORY "https://git.ufz.de/mhm/mhm.git"
  GIT_TAG "${MHM_BUILD_VERSION}"
  INSTALL_COMMAND ""
  CMAKE_ARGS -DCMAKE_BUILD_TYPE=${MHM_BUILD_TYPE} -DCMAKE_WITH_OpenMP=${MHM_BUILD_PARALLEL}
  BUILD_COMMAND ${CMAKE_COMMAND} --build .
)
# prefix comes form ExternalProject
set(mhm-exe ${CMAKE_BINARY_DIR}/mhm-prefix/src/mhm-build/mhm${CMAKE_EXECUTABLE_SUFFIX})
# install destination will be redirected by skbuild
install(PROGRAMS ${mhm-exe} DESTINATION .)
