###W&M Whirlwind cluster
#  Set the base name of the executable.
#  The main reason for this is to include something like a cluster/architecture name.
#  Do not add the file extension (none for linux, .exe for Windows etc)
#  or the list of enabled modules, both of which will be automatically appended.
  set (SCHISM_EXE_BASENAME pschism_GNU_WW CACHE STRING "Base name (modules and file extension to be added of the executable. If you want a machine name, add it here")



##########################  LOCATIONS #########################################################
#
# LOCATIONS: Set locations for NetCDF (possibly HDF5 if NetCDF links to it), ParMetis, PETSc
#            You don't need to set these if they are in your environment
#
#            Only the library home location is needed and the /lib or /bin part will be inferred.
#            Generally traditional structure is assumed, but the Parmetis and GOTM libraries
#            that are included have a slightly different structure
#
#            You only need GOTM if you intend to use it with USE_GOTM
#            GOTM and ParMetis local copies will be found automatically, but also can overridden
#            You have to build them
#

###Relative paths won't work
set(CMAKE_Fortran_COMPILER gfortran CACHE PATH "Path to serial Fortran compiler")
set(CMAKE_C_COMPILER gcc CACHE PATH "Path to serial C compiler")
set(PARMETIS_DIR  /sciclone/home10/yinglong/git/schism/src/ParMetis-3.1-Sep2010/ CACHE PATH "Path to ParMetis")
set(NetCDF_FORTRAN_DIR "$ENV{NETCDF_FORTRAN}" CACHE PATH "Path to NetCDF Fortran library")
set(NetCDF_C_DIR  "$ENV{NETCDF}"  CACHE PATH "Path to NetCDF C library")
###MPI_ROOT is only needed when cmake is having trouble finding write MPI wrapper
#set(MPI_ROOT /opt/mvapich2/2.3-intel CACHE PATH "Root dir of MPI implementation")

#set(HDF5_DIR  /opt/hdf5/1.10.4-intel64 CACHE PATH "Path to HDF5")
#set(SZIP_DIR /opt/szip/2.1.1-intel64 CACHE PATH "Path to SZip compression library")

# PETSC hasn't been maintained, not sure of status (Eli).
#set(PETSC_DIR  /Calcul/Apps/PETSc/3.3-p4.intel/ PATH "Path to PETC, (if unset, defaults to pre-built local copy)")
#set(GOTM_HOME  /home/eli/myscratch/gotm_v5.2 CACHE PATH "Path to GOTM")



######################## COMPILE AND BUILD OPTIONS ##############################################
#
# BUILD OPTS: Use this to set compiler flags any way you want.For models of how to set flags, 
#             see SCHISMCompile.cmake, which are the project defaults.
#
#             If you are setting up a new platform/compiler combo rather than customizing, 
#             you might consider adding to SCHISMCompile.cmake with the correct "IF" so 
#             others can profit from your work.
#             
#             If what you are doing is debugging, consider using -DBUILD_TYPE=Debug and using the default
#             debug flags. Note that there is yet another build type for release plus symbols.
#
#             So far I have removed -Bstatic because it is causes problems and cmake seems to do enough
#             magically.
#
#################################################################################################

#set(INCLUDE_TIMING CACHE BOOLEAN OFF)
#set(USE_OPEN64     CACHE BOOLEAN OFF)

###MPI_VERSION cannot be set here; use -DMPIVERSION=XX in cmake cmd instead
#set(MPI_VERSION CACHE STRING  "1")
#set(MPIVERSION CACHE STRING  "1")
###Compile flags
#CMAKE_EXE_LINKER_FLAGS did not work so I had to remove -static
set(CMAKE_Fortran_FLAGS_RELEASE "-O2 -ffree-line-length-none -static-libgfortran -finit-local-zero" CACHE STRING "Fortran flags" FORCE)
##For final linking: this is only needed in exordinary cases
#set(CMAKE_EXE_LINKER_FLAGS "-O2 -ffree-line-length-none" CACHE STRING "linker" FORCE)


###In build, the usual cmd is: cd build/; cmake -C ../cmake/SCHISM.local.<cluster> ../src; then make -j8
###To see the actual cmd used, use make VERBOSE=1 (note that cmake expands MPI compiler to serial+lib+inc)
###For MPI compiler used, search for 'MPI_Fortran_COMPILER' and 'MPI_C_COMPILER' in build/CMakeCache.txt
