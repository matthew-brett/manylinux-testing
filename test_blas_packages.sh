#!/bin/bash
# Test BLAS-related stack
set -e
export OPENBLAS_VERBOSE=2
if [ -n "$CORE" ]; then export OPENBLAS_CORETYPE=$CORE; fi
python -c 'import numpy; numpy.test("full")'
python -c 'import scipy; scipy.test("full")'
nosetests sklearn
nosetests numexpr
# Exclude failing datetime conversion tests
# https://github.com/pydata/pandas/issues/12729
nosetests --exe -A "not slow and not network and not disabled"
  -e test_parsers -e TestDatetimeParsingWrappers
  -e test_range_slice_seconds -e test_range_slice_day
  pandas
# Statsmodels latest release breaks with latest pandas; use recent trunk
# commit
pip install cython
pip install https://github.com/statsmodels/statsmodels/archive/c89da5cb7c49c7bdd8699df6e7073ace43bd5250.zip
# Exclude extremely slow statsmodels tests
nosetests -e test_vcomp_2 -e test_sarimax --verbosity=3 statsmodels
