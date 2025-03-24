set -euo pipefail

# Disable availability checks on macOS
export CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"

mkdir build && cd build

# Build without CUDA support or vendored libs
cmake ${CMAKE_ARGS} .. \
    -DISCE_CUDA_ARCHS='' -DCMAKE_CUDA_ARCHITECTURES='all-major' \
    -DPython_EXECUTABLE=$PYTHON \
    -DISCE3_FETCH_DEPS=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DISCE_PACKAGESDIR=$SP_DIR \
    -GNinja

ninja install
