# Read by EVERY zsh — login, interactive, scripts, launchd jobs, subprocesses.
# Keep it minimal: only what non-interactive shells must have.

# Homebrew first on PATH in all contexts (Apple Silicon or Intel prefix).
# This is what guarantees background/subprocess shells resolve the same
# node/npm as the terminal — see "Node.js policy" in the README.
for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  if [[ -x $_brew ]]; then
    eval "$($_brew shellenv)"
    break
  fi
done
unset _brew

# Auto-deduplicate PATH entries across nested/sourced shells
typeset -U path
