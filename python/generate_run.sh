#!/usr/bin/env bash

rm -rf build
rm *.so
rm *.cxx
swig -c++ -Wall -python python_api.i
CC=g++-5 python setup.py build_ext --inplace --verbose

