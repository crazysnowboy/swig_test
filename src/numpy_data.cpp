//
// Created by collin on 17-12-5.
//

#include "numpy_data.h"


void numpy_data::NUmpyDataCPP2Python(double *mat, int length, char *flags)
{
    std::string flags_str = flags;
    const int mat_rows =100;
    const int mat_cols =20;
    double testData[mat_rows*mat_cols];
    for(int j=0;j<mat_rows;j++)
    {
        for(int i=0;i<mat_cols;i++)
        {
            testData[j*mat_cols+i]=double(i)/(double)(j+1);
        }
    }
    if(flags_str == "GetLength")
    {
        std::cout <<"print in cpp module------GetLength--" <<std::endl;
        mat[0]=(double)mat_rows;
        mat[1]=(double)mat_cols;
    }
    if(flags_str == "GetData")
    {
        std::cout <<"print in cpp module------GetData--" <<std::endl;
        for(int j=0;j<mat_rows;j++)
        {
            for(int i=0;i<mat_cols;i++)
            {
                mat[j*mat_cols + i] = testData[j*mat_cols + i];
//                std::cout << mat[j*mat_cols + i]<<"  ";
            }
//            std::cout <<std::endl;
        }
    }


}

void numpy_data::NumpyData_Python2CPP(double *mat, int rows, int cols, char *flags)
{

    std::string flags_str = flags;
    std::cout <<"print in cpp module------NumpyData_Python2CPP--" <<std::endl;
    std::cout <<"print in cpp module------flags = "<<flags_str <<std::endl;
    for(int j=0;j<rows;j++)
    {
        for(int i=0;i<cols;i++)
        {
            std::cout << mat[j*cols+i] <<" ";
        }
        std::cout <<std::endl;
    }
}