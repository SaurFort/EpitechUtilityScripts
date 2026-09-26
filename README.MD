# Utility Scripts

A collection of shell scripts designed to automate repetitive tasks and save time during Epitech projects.

Feel free to use and modify them as needed.

## Installation

Run this one-liner in your terminal to clone the repo into `~/my_scripts`, set up execution permissions, and automatically configure aliases for your shell (`bash` or `zsh`):

```bash
curl -fsSL https://raw.githubusercontent.com/SaurFort/EpitechUtilityScripts/main/install_script.sh | bash
```
After installation, reload your shell configuration:

```bash
source ~/.bashrc # or sourc ~/.zshrc
```

## Added commands

Once installed, the scripts and directory path are directly integrated into your environment:

| Command | Type | Description |
| `init_repo` | Scrip alias | Automatically initializes a C project on a repo with prepared files for testing |

*Note:* The directory `~/my_scripts` is automatically added to your `$PATH`, enabling tab completion for all scripts.

## Scripts Details

### init_repo

Initialize a C project repository tailored for Epitech:
- Generates a pre-configured `.gitignore` (ignoring binaries, temporary files, and test folder).
- Sets up the `main` branch and links the remoite Git repository.
- Creates a `tests/` directory populated with standard test helper functions (`my_putchar`, `my_putstr`, `my_put_nbr`, 'my_getnbr') and a header file (`libs.h`).
- Commits and pushes the initial setup automatically.

Usage:
```bash
init_repo
```

The script prompts for the remote Git repository URL (SSH or HTTPS) and the local destination directory (even if the directory is not empty).
