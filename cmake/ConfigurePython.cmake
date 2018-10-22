
file(GLOB_RECURSE files_hpp "${PROJECT_SOURCE_DIR}/include/*.hpp")
file(GLOB_RECURSE files_h "${PROJECT_SOURCE_DIR}/include/*.h")


set(mid_file_save_path ${PROJECT_SOURCE_DIR}/python/cmake_generated)

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
        OUTPUT_DIR ${PROJECT_SOURCE_DIR}/python/
        OUTFILE_DIR ${PROJECT_SOURCE_DIR}/python/outfile_dir
        SOURCES ${PROJECT_SOURCE_DIR}/python/python_api.i ${CPP_SRCS})

swig_link_libraries(${PythonLIBName} ${LIBRARIES}
                /usr/lib/x86_64-linux-gnu/libpython3.5m.so)

set_target_properties(${PythonLIBName} PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/python"
        LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/python"
        RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/python")
