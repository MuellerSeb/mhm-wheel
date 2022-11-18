export CURRENT_DIR=$(pwd)
export INSTAL_DIR=/usr
mkdir _netcdf_build && cd _netcdf_build
git clone https://github.com/zlib-ng/zlib-ng.git
cd zlib-ng
git checkout 2.0.6 # or the version you want
./configure --prefix=${INSTAL_DIR} --zlib-compat
make -j
make install
cd ..
git clone https://github.com/HDFGroup/hdf5.git
cd hdf5
git checkout hdf5-1_12_2 # or the version you want
./configure --with-zlib=${INSTAL_DIR} --prefix=${INSTAL_DIR} --enable-hl
make -j
make install
cd ..
git clone https://github.com/Unidata/netcdf-c.git
cd netcdf-c
git checkout v4.8.1 # or the version you want
CPPFLAGS=-I${INSTAL_DIR}/include LDFLAGS=-L${INSTAL_DIR}/lib ./configure --prefix=${INSTAL_DIR} --disable-dap
make -j
make install
cd ..
git clone https://github.com/Unidata/netcdf-fortran.git
cd netcdf-fortran
git checkout v4.5.4 # or the version you want
# FCFLAGS="-mismatch_all" for NAG
LD_LIBRARY_PATH=${INSTAL_DIR}/lib:${LD_LIBRARY_PATH} CPPFLAGS=-I${INSTAL_DIR}/include LDFLAGS=-L${INSTAL_DIR}/lib ./configure --prefix=${INSTAL_DIR}
make -j
make install
cd $CURRENT_DIR
