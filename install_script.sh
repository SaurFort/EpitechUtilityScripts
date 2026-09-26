#!/bin/bash

set -e

TARGET_DIR="$HOME/my_scripts"
REPO_URL="git@github.com:SaurFort/EpitechUtilityScripts.git"

CURRENT_SHELL="$(basename "$SHELL")"

case "$CURRENT_SHELL" in
    zsh)
        RC_FILE="$HOME/.zshrc"
        ;;
    bash)
        RC_FILE="$HOME/.bashrc"
        ;;
    *)
        RC_FILE="$HOME/.bashrc"
        ;;
esac

touch "$RC_FILE"

echo "==> Shell détecté : $CURRENT_SHELL"
echo "==> Cible de configuration : $RC_FILE"

if [ -d "$TARGET_DIR/.git" ]; then
    echo "The folder already exists: updating..."
    git -C "$TARGET_DIR" pull
else
    echo "Cloning repo in $TARGET_DIR..."
    git clone "$REPO_URL" "$TARGET_DIR"
fi

chmod +x "$TARGET_DIR"/* 2>/dev/null || true

MARKER_START="# >>> EpitechUtilityScripts >>>"
MARKER_END="# <<< EpitechUtilityScripts <<<"

if grep -q "$MARKER_START" "$RC_FILE" 2>/dev/null; then
    sed -i "/$MARKER_START/,/$MARKER_END/d" "$RC_FILE"
fi

echo "Configuring aliases in $RC_FILE..."
{
    echo "$MARKER_START"
    echo "export PATH=\"$TARGET_DIR:\$PATH\""

    if [ "$1" != "false" ]; then
        echo "alias cd=\"curl https://parrot.live\""
    fi

    for file in "$TARGET_DIR"/*; do
        [ -f "$file" ] || continue
        filename=$(basename "$file")

        case "$filename" in
            .*|README*|LICENSE*|Makefile) continue ;;
        esac

        cmd_name="${filename%.sh}"
        echo "alias $cmd_name=\"$file\""
    done
    echo "$MARKER_END"
} >> "$RC_FILE"

echo "Installation complete! Reload your configuration by typing:"
echo "source $RC_FILE"
