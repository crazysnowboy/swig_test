CMAKE_MINIMUM_REQUIRED(VERSION 2.6) #cmake 版本限定
PROJECT(SWIG_Wrap_For_Python)  #工程名称


set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

set(INCLUDE_DIR ${PROJECT_SOURCE_DIR}/include)

add_definitions()
include(cmake/ConfigureOpenCV.cmake)
include(cmake/MyConfigure.cmake)
include(cmake/FindEigen3.cmake)



include_directories(${INCLUDE_DIR})

include(cmake/ConfigurePython.cmake)

file(GLOB_RECURSE toExe_SRCS "${PROJECT_SOURCE_DIR}/src/*.cpp")
file(GLOB_RECURSE ForExe_SRCS "${PROJECT_SOURCE_DIR}/main/*.cpp")
foreach(source ${ForExe_SRCS})
    get_filename_component(SourceName ${source} NAME_WE)
    set(ExeName ${SourceName})
    # target
    set(SRCS_ALL ${source} ${toExe_SRCS})
    add_executable(${ExeName} ${SRCS_ALL})
    # link library
    target_link_libraries(${ExeName}
            ${LIBRARIES}
            )
    set_target_properties(${ExeName} PROPERTIES
            ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin"
            LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin"
            RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin")
endforeach(source)

