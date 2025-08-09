#!/bin/bash

# Generate the README on all modules
# Generate the mkdocs.yaml based on current folder
# Search on subfolders to get all readme files
# copy readme files to docs folder

# Define the root directory and the modules directory
ROOT_DIR="./"
MODULES_DIR="${ROOT_DIR}/modules"
DOCS_DIR="${ROOT_DIR}/docs"

generate_doc_on_modules() {

  for dir in "${MODULES_DIR}"/*/; do
    echo "Generating README.md for $dir"
    terraform-docs markdown table "$dir" > "$dir/README.md"
  done
}

# Function to process each module
process_module() {
  local module_name=$(basename "$1")

  # Check if README.md exists in the subfolder
  if [[ -f "$1/README.md" ]]; then
    echo "Processing $1/README.md"

    # Copy the README.md to the docs directory with a unique name
    mkdir -p "$DOCS_DIR/$module_name"
    cp "$1/README.md" "$DOCS_DIR/$module_name/README.md"
    
    # Append to the master index.md content
    MASTER_INDEX_CONTENT+="\n- [${module_name}](./${module_name}/README.md)"
    
    # Append to mkdocs.yml nav
    MKDOCS_CONFIG+="  - ${module_name}: ${module_name}/README.md\n"
  fi
}

generate_mkdocs() {

  # Ensure the docs directory exists
  mkdir -p "$DOCS_DIR"

  # Initialize the master index.md content
  MASTER_INDEX_CONTENT="# Terraform Modules Documentation\n\n## Modules\n"

  # Initialize mkdocs.yml configuration with theme
  MKDOCS_CONFIG="site_name: Terraform Modules Documentation\n\ndocs_dir: docs\n\ntheme:\n  name: readthedocs\n\nnav:\n  - Home: index.md\n"

  

  # Iterate over immediate subdirectories of the modules directory
  for dir in "${MODULES_DIR}"/*/; do
    process_module "$dir"
  done

  # Write the master index.md content to a file
  echo -e "$MASTER_INDEX_CONTENT" > "${DOCS_DIR}/index.md"

  # Write the mkdocs.yml configuration to a file
  echo -e "$MKDOCS_CONFIG" > "${ROOT_DIR}/mkdocs.yml"

  echo "Documentation generated successfully"
}

echo "Generating README on modules **********************"
generate_doc_on_modules

echo -e "\nGenerating mkdocs on modules **********************"
generate_mkdocs

echo ""
mkdocs serve
