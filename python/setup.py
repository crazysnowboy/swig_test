
#!/usr/bin/env python2
#-*-encoding:utf-8-*-
"""
setup.py
"""

import os
from distutils.core import setup, Extension


def Search_files_Paths(path,flag):
    current_files = os.listdir(path)
    all_files = []
    all_paths = []
    for file_name in current_files:
        full_file_name = os.path.join(path, file_name)
        if full_file_name.endswith(flag):
            all_files.append(full_file_name)

        if os.path.isdir(full_file_name):
            all_paths.append(full_file_name)
            next_level_files,next_level_paths = Search_files_Paths(full_file_name,flag)
            all_files.extend(next_level_files)
            all_paths.extend(next_level_paths)

    return all_files,all_paths

def Search_Sources_Headers(include_dir,src_dir):

    incs_hpp,inc_dir_hpp = Search_files_Paths(include_dir,'.hpp')
    incs_h,inc_dir_h = Search_files_Paths(include_dir,'.h')

    srcs_cpp,src_dir_cpp = Search_files_Paths(src_dir,'.cpp')
    srcs_cc,src_dir_cc = Search_files_Paths(src_dir,'.cc')
    srcs_c,src_dir_c = Search_files_Paths(src_dir,'.c')

    incs=[]
    incs.extend(incs_hpp)
    incs.extend(incs_h)

    inc_dirs=[]
    inc_dirs.extend(inc_dir_hpp)
    inc_dirs.extend(inc_dir_h)


    srcs =[]
    srcs.extend(srcs_cpp)
    srcs.extend(srcs_cc)
    srcs.extend(srcs_c)


    # print "incs = ",incs
    # print "srcs = ",srcs
    # print "inc_dirs = ",inc_dirs


    return incs,srcs,inc_dirs


def Read_From_Files(srcs_path,incs_path,libs_path):

    cxx_files = []
    inc_dirs = []
    libs_files = []

    file = open(srcs_path, 'r')
    lines = file.readlines()
    if len(lines) >0:
        cxx_files = lines[0].split(' ')
        if cxx_files[len(cxx_files)-1]=='':
            cxx_files[len(cxx_files)-1]=module_name+'_wrap.cxx'
        else:
            cxx_files.append(module_name+'_wrap.cxx')


    file = open(incs_path, 'r')
    lines = file.readlines()
    if len(lines) >0:
        inc_dirs = lines[0].split(' ')
        if inc_dirs[len(inc_dirs)-1]=='':
            inc_dirs.pop()

    file = open(libs_path, 'r')
    lines = file.readlines()
    if len(lines) >0:
        libs_files = lines[0].split(' ')
        libs_files.pop()

    return cxx_files,inc_dirs,libs_files



if __name__ == "__main__":


    module_name='python_api'


    srcs_path = 'cmake_generated/srcs.txt';
    incs_path = 'cmake_generated/inc_dirs.txt'
    libs_path =  'cmake_generated/libs.txt'




    cxx_files,inc_dirs,libs_files = Read_From_Files(srcs_path,incs_path,libs_path)

    # print "cxx_files = ",cxx_files
    # print "libs_files = ",libs_files


    module = Extension('_'+module_name,
                       sources=cxx_files,
                       include_dirs = inc_dirs,
                       extra_link_args = libs_files,
                       extra_compile_args = ['-std=c++11']
                       )


    setup (name = module_name,
           version = '0.1',
           author      = "crazysnowboy",
           description = """-----------Mesh processing----------""",
           ext_modules = [module],

           py_modules = ["module_name"],
           )