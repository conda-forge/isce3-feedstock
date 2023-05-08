set -euo pipefail

# Workaround for leftover build directory paths in HDF5 installation
# https://github.com/HDFGroup/hdf5/issues/2422
sed -i.tmp 's/-I.*H5FDsubfiling//' \
    "$(which h5cc)" \
    "$(which h5c++)"

# Disable availability checks on macOS
export CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"

mkdir build && cd build

# Build without CUDA support or vendored libs
cmake .. \
    -DPython_EXECUTABLE=$PYTHON \
    -DISCE3_FETCH_DEPS=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DISCE_PACKAGESDIR=$SP_DIR \
    -GNinja

ninja install
