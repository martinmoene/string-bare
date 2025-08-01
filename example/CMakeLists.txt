# Copyright 2025-2025 by Martin Moene
#
# https://github.com/martinmoene/span-bare
#
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

if( NOT DEFINED CMAKE_MINIMUM_REQUIRED_VERSION )
    cmake_minimum_required( VERSION 3.5 FATAL_ERROR )
endif()

project( example LANGUAGES CXX )

# unit_name provided by toplevel CMakeLists.txt
set( PACKAGE   ${unit_name}-bare )

message( STATUS "Subproject '${PROJECT_NAME}'")

# Target default options and definitions:

set( OPTIONS "" )
set( DEFINITIONS "" )

# Sources (.cpp) and their base names:

set( SOURCES
    01-basic.cpp
)

string( REPLACE ".cpp" "" BASENAMES "${SOURCES}" )

# Function to create a target:

function( make_target source )
    # string( REPLACE ".cpp" "" target "${source}" )
    add_executable            ( ${target} ${source}.cpp  )
    target_link_libraries     ( ${target} PRIVATE ${PACKAGE} )
    target_compile_options    ( ${target} PRIVATE ${OPTIONS} )
    target_compile_definitions( ${target} PRIVATE ${DEFINITIONS} )
endfunction()

# Targets:

enable_testing()

foreach( target ${BASENAMES} )
    make_target( ${target} )
endforeach()

# end of file
