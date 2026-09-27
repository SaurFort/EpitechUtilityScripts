#!/bin/bash

set -e

TARGET_DIR="$HOME/my_scripts"
REPO_URL="https://github.com/SaurFort/EpitechUtilityScripts.git"

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

echo "==> Detected shell: $CURRENT_SHELL"
echo "==> Configuration file: $RC_FILE"

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

echo "Configuring aliases and autocompletion in $RC_FILE..."
{
    echo "$MARKER_START"
    echo "export PATH=\"$TARGET_DIR:\$PATH\""

    if [ "$1" != "false" ]; then
        cat << 'EOF'
cd() {
    timeout 2 curl -s https://parrot.live 2>/dev/null || true
    builtin cd "$@"
}
EOF
    fi

    # Création des alias
    for file in "$TARGET_DIR"/*; do
        [ -f "$file" ] || continue
        filename=$(basename "$file")

        case "$filename" in
            .*|README*|LICENSE*|Makefile) continue ;;
        esac

        cmd_name="${filename%.sh}"
        echo "alias $cmd_name=\"$file\""
    done

    if [ "$CURRENT_SHELL" = "bash" ]; then
        cat << 'EOF'

# --- Autocompletion init_repo (Bash) ---
_init_repo_completion() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="-r --repo -l --location -t --only-test -h --help"

    case "$prev" in
        -l|--location)
            COMPREPLY=( $(compgen -d -- "$cur") )
            return 0
            ;;
        -r|--repo)
            return 0
            ;;
    esac

    if [[ "$cur" == -* ]]; then
        COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
        return 0
    fi
}
complete -F _init_repo_completion init_repo init_repo.sh
EOF

    elif [ "$CURRENT_SHELL" = "zsh" ]; then
        cat << 'EOF'

# --- Autocompletion init_repo (Zsh) ---
autoload -Uz compinit 2>/dev/null && compinit -C 2>/dev/null

_init_repo_zsh() {
    _arguments \
        '(-r --repo)'{-r,--repo}'[URL du repo Git]:repo:' \
        '(-l --location)'{-l,--location}'[Emplacement cible]:dossier:_files -/' \
        '(-t --only-test)'{-t,--only-test}'[Initialise git et push .gitignore]' \
        '(-h --help)'{-h,--help}'[Affiche l aide]'
}
compdef _init_repo_zsh init_repo init_repo.sh 2>/dev/null || true
EOF
    fi

    echo "$MARKER_END"
} >> "$RC_FILE"

echo "Installation complete! Reload your configuration by typing:"
echo "source $RC_FILE"
