mkdir _netcdf_build
cd _netcdf_build
mkdir resources
mkdir local
export LOCALDIR=$(pwd)/local
cd resources
git clone https://github.com/zlib-ng/zlib-ng.git
cd zlib-ng
git checkout 2.0.6 # or the version you want
./configure --prefix=${LOCALDIR} --zlib-compat
make -j
make install
cd ..
git clone https://github.com/HDFGroup/hdf5.git
cd hdf5
git checkout hdf5-1_12_2 # or the version you want
./configure --with-zlib=${LOCALDIR} --prefix=${LOCALDIR} --enable-hl
make -j
make install
cd ..
git clone https://github.com/Unidata/netcdf-c.git
cd netcdf-c
git checkout v4.8.1 # or the version you want
CPPFLAGS=-I${LOCALDIR}/include LDFLAGS=-L${LOCALDIR}/lib ./configure --prefix=${LOCALDIR} --disable-dap
make -j
make install
cd ..
git clone https://github.com/Unidata/netcdf-fortran.git
cd netcdf-fortran
git checkout v4.5.4 # or the version you want
# FCFLAGS="-mismatch_all" for NAG
LD_LIBRARY_PATH=${LOCALDIR}/lib:${LD_LIBRARY_PATH} CPPFLAGS=-I${LOCALDIR}/include LDFLAGS=-L${LOCALDIR}/lib ./configure --prefix=${LOCALDIR}
make -j
make install
cd ..
# export NetCDF_ROOT=${LOCALDIR}
cd ../..
