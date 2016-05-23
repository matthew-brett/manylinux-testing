#!/bin/bash
set -e
git clone https://github.com/matplotlib/matplotlib mpl-source
cd mpl-source
git checkout "v$MPL_VERSION"
MPL_INSTALL_DIR=$(dirname $(python -c 'import matplotlib; print(matplotlib.__file__)'))
cp -r lib/matplotlib/tests/baseline_images $MPL_INSTALL_DIR/tests
cd ..
python -c 'import matplotlib; print(matplotlib.__file__)'
python mpl-source/tests.py
