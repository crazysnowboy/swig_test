//
// Created by collin on 17-12-5.
//

#ifndef SWIG_WRAP_FOR_PYTHON_NUMPY_DATA_H
#define SWIG_WRAP_FOR_PYTHON_NUMPY_DATA_H

#include <iostream>
class numpy_data
{
public:

    void NUmpyDataCPP2Python(double *mat, int length, char *flags);

    void NumpyData_Python2CPP(double *mat, int rows, int cols, char *flags);


};


#endif //SWIG_WRAP_FOR_PYTHON_NUMPY_DATA_H
