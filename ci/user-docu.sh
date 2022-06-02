#!/usr/bin/env bash
set -e

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source ${BUILD_DIR}/ci/common/common.sh
source ${BUILD_DIR}/ci/common/doc.sh
source ${BUILD_DIR}/ci/common/html.sh

generate_user_docu() {
  require_environment_variable BUILD_DIR "${BASH_SOURCE[0]}" ${LINENO}
  require_environment_variable MAKE_CMD "${BASH_SOURCE[0]}" ${LINENO}

  # Generate CMake files
  cd ${NEOVIM_DIR}
  make cmake

  # Build user manual HTML
  cd build
  echo "CWD: $(pwd)"
  ${MAKE_CMD} doc_html

  # Copy to doc repository
  rm -rf ${DOC_DIR}/user
  mkdir -p ${DOC_DIR}/user
  cp runtime/doc/*.html ${DOC_DIR}/user

  # Modify HTML to match Neovim's layout
  # modify_user_docu
}

DOC_SUBTREE="/user/"
generate_user_docu
