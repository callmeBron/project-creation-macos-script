# 🚀 Project Creator Script
A simple bash script to quickly create new project directories from a template folder on macOS.

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
  - [First Time Setup](#first-time-setup)
  - [Basic Usage](#basic-usage)
  - [Examples](#examples)
  - [Output Path Options](#output-path-options)
- [Configuration](#configuration)
  - [Default Template Folder](#default-template-folder)
  - [Using a Different Template Folder Name](#using-a-different-template-folder-name)
- [Template Folder Structure](#template-folder-structure)
- [Safety Features](#safety-features)
- [Troubleshooting](#troubleshooting)
- [Requirements](#requirements)
- [License](#license)

## Features

- 🚀 Quickly scaffold new projects from a base template
- ✅ Validates input and checks for existing directories
- 🎨 Color-coded terminal output (because pretty terminals make us happy)
- 🔒 Safe operation with confirmation prompts (no accidental overwrites!)
- 📝 Easy to customize and extend
- 🎯 Interactive prompts ... just run and answer questions!

## Installation

1. Download or copy the entire folder containing:
   - `create-project.sh` (the script)
   - `vscode-cpp-template/` (your template folder with all base files)
   - `README.md` (this documentation)

2. **Make the script executable (required):**
   ```bash
   chmod +x create-project.sh
   ```
   > ⚠️ **Important:** If you skip this step, you'll get a "permission denied" error!
   >
   
   and then run the command
   ```bash
   ./create-project.sh
   ```
4. (Optional) Move to a directory in your PATH for global access:
   ```bash
   # Note: You'll need to keep the template folder accessible
   sudo mv create-project.sh /usr/local/bin/create-project
   ```
   > Then you can run `create-project` from anywhere! 🎉

## Usage

### First Time Setup

Before running the script for the first time, make it executable (if you have not already done this):

```bash
chmod +x create-project.sh
```

### Basic Usage

```bash
./create-project.sh
```

The script will prompt you interactively:

```
Create new project
Directory name: my-awesome-app
Output path (leave empty for current directory): ~/Projects
```

This will create a new directory at the specified location, copying all files from the default base template folder.
 > 💡 **Tip:** Leave the output path empty to create your project in the current directory!
 
### Examples

```bash
# Create a new project in current directory
./create-project.sh
# Directory name: my-awesome-app
# Output path: (press Enter for current directory)

# Create a new project in a specific location
./create-project.sh
# Directory name: gameDev
# Output path: ~/Documents/Projects

# Create a new project using a custom template
./create-project.sh ~/templates/web-template
# Directory name: web-project
# Output path: ~/Sites

# If installed globally
create-project
# Then enter your project details when prompted
```

### Output Path Options

- **Leave empty**: Creates project in current directory
- **Relative path**: `../projects` or `subfolder`
- **Absolute path**: `/Users/yourname/Projects`
- **Home directory**: `~/Projects` (tilde expands to your home directory)

> 📝 **Note:** If the path doesn't exist, the script will ask if you want to create it!

## ⚙️ Configuration

### Default Template Folder

The script looks for a `vscode-cpp-template` folder in the same directory. Your folder structure should be:
```
CreateNewProjectFolder/
├── create-project.sh          # The script ✨
├── vscode-cpp-template/       # Your template files
│   ├── main.code-workspace
│   ├── libstdc++-6.dll
│   └── ... (all your template files)
└── README.md                  # This file!
```

The script automatically finds the template folder relative to its own location, so you can move the entire folder anywhere and it will still work.

## Using a Different Template Folder Name

If you want to use a different folder name, edit the script and change this line:

```bash
DEFAULT_BASE_FOLDER="$SCRIPT_DIR/template"
```

For example, to use a folder named `base-project`:
```bash
DEFAULT_BASE_FOLDER="$SCRIPT_DIR/base-project"
```

## Template Folder Structure

Your `template` folder (bundled with the script) should contain all the files and folders you want in every new project:

```
template/
├── .gitignore
├── README.md
├── LICENSE
├── src/
│   └── main.js
├── tests/
│   └── test.js
├── package.json
└── .env.example
```

When you run the script, all of these files and folders will be copied to your new project directory.

## Safety Features

- **Existence Check**: Validates that the template folder exists before proceeding
- **Overwrite Protection**: Prompts for confirmation if target directory already exists
- **Error Handling**: Exits on errors to prevent partial copies

## Troubleshooting

### "Permission denied" error
Make sure the script is executable:
```bash
chmod +x create-project.sh
```

### "Base folder does not exist" error
Make sure you have a `template` folder in the same directory as the script:
```bash
ls -la template/
```

Your folder structure should be:
```
YourFolder/
├── create-project.sh
└── template/
```

### Script doesn't run
Ensure you're using bash (default on macOS):
```bash
bash create-project.sh
```
## Requirements

- macOS (or any Unix-like system with bash)
- Bash 3.0 or higher (included in macOS)

## License

Free to use and modify as needed.

## Support

If you encounter issues, check that:
1. The script has execute permissions
2. Your template folder path is correct
3. You have write permissions in the current directory


## 🎉 Congratulations!
When you successfully create a project, you'll see this beauty:
<img width="899" height="706" alt="image" src="https://github.com/user-attachments/assets/f6a1869c-5ac4-4da6-8f08-9726cfb29951" />

<div align="center">

Made with ❤️ and lots of ☕

[Report Bug](../../issues) · [Request Feature](../../issues)

</div>⠀⠀⠀
