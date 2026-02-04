#!/bin/bash

# Script used to create a new project directory from a base template
# Usage: ./create-project.sh [base-folder-path]
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Default base folder (template folder in same directory as script)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_BASE_FOLDER="$SCRIPT_DIR/template"
BASE_FOLDER="${1:-$DEFAULT_BASE_FOLDER}"

# Prompt for project name
echo -e "${GREEN}Create new project${NC}"
read -p "Directory name: " PROJECT_NAME

# Check if project name is provided
if [ -z "$PROJECT_NAME" ]; then
    echo -e "${RED}Error: Project name cannot be empty${NC}"
    exit 1
fi

# Prompt for output path
read -p "Output path (leave empty for current directory): " OUTPUT_PATH

# Use current directory if no path specified
if [ -z "$OUTPUT_PATH" ]; then
    OUTPUT_PATH="."
fi

# Expand tilde to home directory
OUTPUT_PATH="${OUTPUT_PATH/#\~/$HOME}"

# Create output directory if it doesn't exist
if [ ! -d "$OUTPUT_PATH" ]; then
    echo -e "${YELLOW}Output path '$OUTPUT_PATH' does not exist${NC}"
    read -p "Create it? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mkdir -p "$OUTPUT_PATH"
        echo -e "${GREEN}✓ Created output directory${NC}"
    else
        echo "Operation cancelled"
        exit 0
    fi
fi

# Full path for the new project
PROJECT_PATH="$OUTPUT_PATH/$PROJECT_NAME"

# Validate base folder exists
if [ ! -d "$BASE_FOLDER" ]; then
    echo -e "${RED}Error: Base folder '$BASE_FOLDER' does not exist${NC}"
    exit 1
fi

# Check if project directory already exists
if [ -d "$PROJECT_PATH" ]; then
    echo -e "${YELLOW}Warning: Directory '$PROJECT_PATH' already exists${NC}"
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Operation cancelled"
        exit 0
    fi
    rm -rf "$PROJECT_PATH"
fi

# Create the project directory
echo -e "${Yellow}Creating project: $PROJECT_NAME${NC}"
echo "${Yellow}Location: $PROJECT_PATH"
echo "${Yellow}Copying from: $BASE_FOLDER"

# Copy all files and folders from base folder
cp -R "$BASE_FOLDER" "$PROJECT_PATH"

# Feedback for the user
echo ""
echo -e "${GREEN}"
cat << "EOF"

⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠴⠒⠚⠛⠉⠉⠙⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡶⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡞⠋⠀⠀⠀⠀⠙⡇⠀⠀⠀⠀⠀⠀⠀⠀⣰⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡟⠀⠀⠀⠀⠀⠀⢀⣇⠀⠀⠀⠀⠀⠀⠀⢀⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⠁⠀⠀⠀⠀⠀⢰⣶⡏⠀⠀⠀⠀⠀⠀⢀⡾⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⠛⠀⢠⡄⠀⠀⣠⣤⣄⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠇⠀⠀⠀⠀⠀⠀⣫⣾⠇⠀⠀⠀⠀⠀⠀⢸⠇⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⢸⠃⠀⠀⠿⠟⠙⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡟⠀⠀⠀⠀⠀⠀⠀⠙⢿⠀⠀⠀⠀⠀⠀⠀⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⢸⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡇⠀⠀⠀⠀⠀⠀⠀⢓⣾⠀⠀⠀⠀⠀⠀⢀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣆⠀⣀⣀⣀⠀⣼⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⢠⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠀⠀⠀⠀⠀⠀⠀⠀⠈⢛⣿⠛⠉⠁⠈⠙⢿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⢂⣟⣤⠤⢤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡄⠀⠀⠀⠀⠀⠀⠀⠀⡤⣿⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣤⣴⠀⠀⠀⠀⢠⡗⠀⠀⠀⠀⢠⣿⠃⠀⠀⠀⠈⠛⢦⣄⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡀⠀⠀⠀⠀⠀⠀⢈⢩⣿⡥⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢧⣀⡀⠀⠈⢁⡄⠀⠀⣰⣿⣂⣞⠃⠀⠀⠀⡐⠀⠃⠙⠳⢦⣄⡀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡇⠀⠀⠀⠀⠀⠀⢸⣿⣿⣵⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠿⣽⡟⠛⠻⠇⢀⣴⠏⠉⠙⠃⢠⣤⣀⠈⢲⣦⢳⣃⡤⢤⣀⠉⠳⢶
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣼⣧⣤⣤⣄⣀⣀⡀⣿⣿⣽⣿⠁⠀⠀⠀⠀⡀⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡿⠇⠀⠐⢀⢠⣸⢇⠙⠳⢦⣄⡙⢙⣛⢿⣟⣇⠀⣾
⢰⠏⠉⠉⠉⠉⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀⠈⠉⠋⣻⣟⠛⠿⣿⣧⠀⠀⠀⡎⣯⣟⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣰⣟⣡⡄⠀⠀⠹⣻⡿⠊⠀⠀⠀⠈⠙⣲⢽⣿⣿⣟⣼⠋
⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠔⡄⢿⡔⡐⢝⣗⠀⠀⢐⡢⢾⠫⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣷⢿⣿⡽⠁⠀⣹⣱⢟⡀⠀⠀⠀⠀⢀⣴⠿⡟⠏⢛⡿⠃⠀
⠹⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⢪⠂⠐⢸⡇⠈⠴⠻⠆⢐⣼⡞⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠿⠿⠟⠁⠀⡛⣥⣿⠀⠀⠀⠀⢀⣴⠏⠭⡀⣰⣫⠟⠁⠀⠀
⠀⠈⡏⠁⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⣀⣠⣾⣶⢾⣾⢷⣄⢀⢸⢄⣾⣿⣯⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢆⣿⡍⠀⢀⣀⣴⣏⣥⣌⣰⣷⠞⠁⠀⠀⠀⠀
⠀⣸⠇⠀⠀⠀⠀⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡂⢣⣽⡍⣺⣟⣿⣿⣹⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢴⣓⣿⣿⣿⣹⣾⣿⣿⣿⡿⠋⠁⠀⠀⠀⠀⠀⠀
⠀⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠠⠈⢴⣶⣻⣿⣿⣿⣿⣯⡿⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣱⣿⣿⣿⣿⡿⣿⣿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠈⡀⢷⢿⣝⣿⣿⣿⣿⣿⡇⠈⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⡿⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣙⣷⣠⣾⣿⣿⣉⠿⠿⡿⣽⠀⠀⢸⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢹⠾⣦⡭⣾⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠈⠻⣷⠀⠀⠀⠀⠀⣀⣠⣤⠤⠤⠖⠚⠛⠉⠙⠘⣍⢸⢧⢻⡀⠀⣧⡏⠀⠀⠀⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠘⠃⠈⠙⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢸⠀⠀⠀⠀⠀⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⢹⡇⢠⣿⠁⠀⠀⠀⠹⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠀⠀⠐⠄⣻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢼⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄⠂⠀⠓⢠⣼⠃⢸⡏⠀⠀⠀⠀⠀⢹⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡀⢂⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣢⣿⣶⣷⠞⢿⡆⣾⠀⠀⠀⠀⠀⠀⠀⢻⡄⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⡇⠀⠠⠄⠠⠀⠐⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⡴⠞⠋⢹⣘⣓⣭⣷⣿⣴⠏⠀⠀⠀⠀⠀⠀⠀⠀⢿⡄⠀⠀⠀⠀⠀⢀⣠⢌⣿⡇⠀⠊⠉⠠⠀⠀⢸⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠻⣦⠀⠀⠀⠀⠀⠘⠚⠋⠉⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣄⠀⠀⠀⠀⠈⣏⡭⢿⣏⠀⠌⠂⠠⠀⠈⣸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠙⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢧⡀⠀⠀⠀⣴⣃⡀⣏⡁⢀⠀⡀⠀⢂⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣬⣿⠿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⢦⡀⠀⢶⣾⣼⣟⡀⠱⠄⠀⠀⢪⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠈⢻⣄⡀⠀⠀⣀⣶⡾⠛⠋⠋⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣦⠓⢿⢼⣷⡂⢤⠠⢠⡤⣸⠃⠀⠀⠀⠀⠀

EOF

echo -e "${GREEN}✓ Project '$PROJECT_NAME' created successfully!${NC}"
echo ""
echo "Next steps:"
echo "  cd $PROJECT_PATH"
echo ""
