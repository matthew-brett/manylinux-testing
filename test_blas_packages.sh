#!/bin/bash
# Test BLAS-related stack
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
# Exclude extremely slow statsmodels tests
nosetests -e test_vcomp_2 -e test_sarimax --verbosity=3 statsmodels
