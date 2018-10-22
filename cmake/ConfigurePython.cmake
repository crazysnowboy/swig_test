file(GLOB_RECURSE files_cpp_src "${PROJECT_SOURCE_DIR}/src/*.cpp")
file(GLOB_RECURSE files_c_src "${PROJECT_SOURCE_DIR}/src/*.c")

file(GLOB_RECURSE files_hpp "${PROJECT_SOURCE_DIR}/include/*.hpp")
file(GLOB_RECURSE files_h "${PROJECT_SOURCE_DIR}/include/*.h")


set(mid_file_save_path ${PROJECT_SOURCE_DIR}/python/cmake_generated)

#for Bind numpy
list(APPEND INCLUDE_DIR  /home/collin/Space_1_5_T/MySoftware/python/numpy/numpy/core/include)

foreach(file ${files_cpp_src})
     list(APPEND srcs ${file} " ")
endforeach(file)
foreach(file ${files_c_src})
    list(APPEND srcs ${file} " ")
endforeach(file)
file(WRITE ${mid_file_save_path}/srcs.txt ${srcs})

#--------------headers.h---------------------
foreach(file ${files_hpp})
    list(APPEND incs "#include \"${file}\"\n")
endforeach(file)
foreach(file ${files_h})
    list(APPEND incs "#include \"${file}\" \n")
endforeach(file)
file(WRITE ${mid_file_save_path}/headers.h ${incs})

##--------------incs_for_wrap.i---------------------
foreach(file ${files_hpp})
    list(APPEND incs_2 "%include \"${file}\"\n")
endforeach(file)
foreach(file ${files_h})
    list(APPEND incs_2 "%include \"${file}\" \n")
endforeach(file)
file(WRITE ${mid_file_save_path}/incs_for_wrap.i ${incs_2})


##--------------inc_dirs.txt---------------------
foreach(file ${INCLUDE_DIR})
    list(APPEND inc_dirs ${file} " ")
endforeach(file)
file(WRITE ${mid_file_save_path}/inc_dirs.txt ${inc_dirs})

##--------------libs-------------------
foreach(file ${LIBRARIES})
    list(APPEND libs ${file} " ")
endforeach(file)
#list(APPEND libs ${PROJECT_SOURCE_DIR}/lib/libmyclib.so " "
#                 ${PROJECT_SOURCE_DIR}/lib/libmycpplib.so " ")

list(APPEND libs )
file(WRITE ${mid_file_save_path}/libs.txt ${libs})
#file(WRITE ${mid_file_save_path}/libmyclib.conf ${PROJECT_SOURCE_DIR}/lib)



cmake_policy(SET CMP0078 NEW)
find_package(SWIG REQUIRED)
include(UseSWIG)
include_directories(/usr/include/python3.5m
                    ${PROJECT_SOURCE_DIR}/python)

if(${SWIG_FOUND})
        message(" SWIG Found SWIG_DIR  = " ${SWIG_DIR})
        message(" SWIG Found SWIG_EXECUTABLE  = " ${SWIG_EXECUTABLE})
        message(" SWIG Found SWIG_VERSION  = " ${SWIG_VERSION})
endif()
set_property(   SOURCE ${PROJECT_SOURCE_DIR}/python/python_api.i 
                PROPERTY CPLUSPLUS ON)

file(GLOB_RECURSE CPP_SRCS "${PROJECT_SOURCE_DIR}/src/*.cpp")
set(PythonLIBName python_api)
swig_add_library(${PythonLIBName}
        LANGUAGE python
        TYPE SHARED
        OUTPUT_DIR ${PROJECT_SOURCE_DIR}/python/output_dir
        OUTFILE_DIR ${PROJECT_SOURCE_DIR}/python/outfile_dir
        SOURCES ${PROJECT_SOURCE_DIR}/python/python_api.i ${CPP_SRCS})

swig_link_libraries(${PythonLIBName} ${LIBRARIES}
                /usr/lib/x86_64-linux-gnu/libpython3.5m.so)

set_target_properties(${PythonLIBName} PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/python"
        LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/python"
        RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/python")
