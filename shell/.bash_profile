# macOS bash login shells read .bash_profile, not .bashrc — source it explicitly
[[ -f "$HOME/.bashrc" ]] && source "$HOME/.bashrc"
