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
source ~/.bashrc # or source ~/.zshrc
```

## Added commands

Once installed, the scripts and directory path are directly integrated into your environment:

| Command     | Type         | Description                                                                     |
|-------------|--------------|----------------------------------------------------------------------------------|
| `init_repo` | Script alias | Automatically initializes a C project on a repo with prepared files for testing |

*Note:* The directory `~/my_scripts` is automatically added to your `$PATH`. Full shell autocompletion (flags and directory navigation) is active for both `init_repo` and `init_repo.sh`.

## Scripts Details

### init_repo

Initialize a C project repository tailored for Epitech:
- Generates a pre-configured `.gitignore` (ignoring binaries, temporary files, and test folder).
- Sets up the `main` branch and links the remote Git repository.
- Creates a `tests/` directory populated with standard test helper functions (`my_putchar`, `my_putstr`, `my_put_nbr`, `my_getnbr`) and a header file (`libs.h`).
- Commits and pushes the initial setup automatically.

#### Options & Flags

| Flag | Long Option        | Description                                                                 |
|------|--------------------|------------------------------------------------------------------------------|
| `-r` | `--repo <url>`     | Remote Git repository URL (SSH or HTTPS)                                    |
| `-l` | `--location <path>`| Target destination directory                                                |
| `-t` | `--only-test`      | Skips the `.gitignore`/git init/push step and only generates the `tests/` files |
| `-h` | `--help`           | Shows the help message                                                      |

Usage:
```bash
init_repo
```

If `-r`/`--repo` or `-l`/`--location` are not provided, the script prompts for them interactively. The destination directory is created automatically if it doesn't exist (even if it's not empty).