#
# Copyright(c) 2020 ADLINK Technology Limited and others
#
# This program and the accompanying materials are made available under the
# terms of the Eclipse Public License v. 2.0 which is available at
# http://www.eclipse.org/legal/epl-2.0, or the Eclipse Distribution License
# v. 1.0 which is available at
# http://www.eclipse.org/org/documents/edl-v10.php.
#
# SPDX-License-Identifier: EPL-2.0 OR BSD-3-Clause
#

include(GenerateVenv)

# although the following files are generated, they are checked into source
# control for convenience, but the user must copy them manually
set(cyclonedds_rnc "${CMAKE_CURRENT_BINARY_DIR}/cyclonedds.rnc")
set(cyclonedds_xsd "${CMAKE_CURRENT_BINARY_DIR}/cyclonedds.xsd")
set(options_md "${CMAKE_CURRENT_BINARY_DIR}/manual/options.md")

if(BUILD_SCHEMA)
  add_custom_command(
    OUTPUT "${cyclonedds_rnc}" "${cyclonedds_xsd}" "${options_md}"
    COMMAND ddsconf ARGS -f rnc -o "${cyclonedds_rnc}"
    COMMAND ddsconf ARGS -f xsd -o "${cyclonedds_xsd}"
    COMMAND ${CMAKE_COMMAND} -E make_directory manual
    COMMAND ddsconf ARGS -f md -o "${options_md}"
    DEPENDS ddsconf)
  add_custom_target(
    schema ALL DEPENDS "${cyclonedds_rnc}" "${cyclonedds_xsd}" "${options_md}")
endif()

if(BUILD_DOCS)
  python3_use_venv(pydocs "${CMAKE_CURRENT_BINARY_DIR}/venv")
  python3_ensure_package(sphinx)
  python3_ensure_package(breathe)
  python3_ensure_package(exhale)
  python3_ensure_package(sphinx-rtd-theme)

  add_custom_target(build_the_docs ALL
    COMMAND ${Python3_EXECUTABLE}
    -m sphinx
    "${CMAKE_CURRENT_SOURCE_DIR}/manual"
    "${CMAKE_CURRENT_BINARY_DIR}/docs"
    DEPENDS
    "${CMAKE_SOURCE_DIR}/src/core/ddsc/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/manual"
  )

  install(
    DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/docs"
    DESTINATION "${CMAKE_INSTALL_DOCDIR}/manual"
    COMPONENT dev)
endif()
