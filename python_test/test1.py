# -*- coding: utf-8 -*
import sys
mesh_pro_root = '../'
sys.path.insert(0, mesh_pro_root + '/python')
import python_api as my_py

import numpy as np

print(dir(my_py))
np_data = my_py.numpy_data()

data_size = np_data.NUmpyDataCPP2Python(2,"GetLength")
data1 = np_data.NUmpyDataCPP2Python(int(data_size[0]) * int(data_size[1]),"GetData")
print ("mat data from cpp = ",data1)

data2 = np.array([[1,2,4,5],[4,5,6,7]])

print ("mat data from python ,should send to cpp module = ",data2)


np_data.NumpyData_Python2CPP(data2,"good")