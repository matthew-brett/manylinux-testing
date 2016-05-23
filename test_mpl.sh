#!/bin/bash
set -e
git clone https://github.com/matplotlib/matplotlib mpl-source
cd mpl-source
git checkout "v$MPL_VERSION"
MPL_INSTALL_DIR=$(dirname $(python -c 'import matplotlib; print(matplotlib.__file__)'))
cp -r lib/matplotlib/tests/baseline_images $MPL_INSTALL_DIR/tests
cd ..
echo "Matplotlib importing from:"
python -c 'import os, matplotlib; print(os.path.dirname(matplotlib.__file__))'
echo "Testing tkagg import"
python -c 'import matplotlib; matplotlib.use("tkagg"); import matplotlib.pyplot as plt'
echo "MPL tests:"
python mpl-source/tests.py
