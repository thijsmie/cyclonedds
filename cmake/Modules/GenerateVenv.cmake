# Copyright(c) 2021 ADLINK Technology Limited and others
#
# This program and the accompanying materials are made available under the
# terms of the Eclipse Public License v. 2.0 which is available at
# http://www.eclipse.org/legal/epl-2.0, or the Eclipse Distribution License
# v. 1.0 which is available at
# http://www.eclipse.org/org/documents/edl-v10.php.
#
# SPDX-License-Identifier: EPL-2.0 OR BSD-3-Clause


function(PYTHON3_USE_VENV _name _dir)
    if(NOT "${PYTHON_MANAGED_VENV_${_name}_CREATED}" OR NOT EXISTS ${_dir})
        find_package(Python3 REQUIRED COMPONENTS Interpreter)
        execute_process(
            COMMAND ${Python3_EXECUTABLE}
            -m venv ${_dir}
            RESULT_VARIABLE _result
            ERROR_VARIABLE _error
            OUTPUT_VARIABLE _output
        )
        if (NOT _result EQUAL "0")
            message("${_output}")
            message("${_error}")
            message(FATAL_ERROR "Your python3 installation does not have the 'venv' module, which is usually in the standard library."
                "If you are using your system python, try to install 'python3-venv'.")
        endif()
        # Clear out python (we will find the venv)
        unset(Python3_EXECUTABLE)
        set(${PYTHON_MANAGED_VENV_${_name}_CREATED} 1)
    endif()
    set (Python3_EXECUTABLE "${_dir}/bin/python" PARENT_SCOPE)
endfunction()

function(PYTHON3_ENSURE_PACKAGE _package)
    # pip will just exit with 'Requirement already satisfied' if we have it already
    message(STATUS "Checking and optionally installing ${_package}")
    execute_process(
        COMMAND ${Python3_EXECUTABLE} -m pip install ${_package}
        OUTPUT_VARIABLE _output
        ERROR_VARIABLE _error
        RESULT_VARIABLE _result_install)
    if (NOT _result_install EQUAL "0")
        message("${_output}")
        message("${_error}")
        message(FATAL_ERROR "Failed to install python package ${_package}.")
    endif()
endfunction()