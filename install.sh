#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if command -v brew >/dev/null 2>&1; then
    echo "🍺 Installing Homebrew dependencies..."
    brew bundle --file="$DOTFILES_DIR/Brewfile"
fi

if ! command -v qmd >/dev/null 2>&1 && command -v npm >/dev/null 2>&1; then
    echo "📦 Installing qmd (https://github.com/tobi/qmd)..."
    npm install -g @tobilu/qmd
fi

echo "🔗 Installing dotfiles with stow..."

# Core packages (cross-platform)
stow -d "$DOTFILES_DIR" -t ~ shell
stow -d "$DOTFILES_DIR" -t ~ editor
stow -d "$DOTFILES_DIR" -t ~ git
stow -d "$DOTFILES_DIR" -t ~ tools
stow -d "$DOTFILES_DIR" -t ~ terminal
stow -d "$DOTFILES_DIR" -t ~ bin

# Platform-specific
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 macOS detected"
    stow -d "$DOTFILES_DIR" -t ~ launchd
    echo "  Loading QMD LaunchAgents..."
    for label in com.qmd.update com.qmd.refresh; do
        launchctl bootout "gui/$(id -u)/$label" 2>/dev/null || true
        launchctl bootstrap "gui/$(id -u)" "$HOME/Library/LaunchAgents/$label.plist"
    done
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "🐧 Linux detected"
    # Add Linux-specific packages here if needed
fi

echo "✅ Dotfiles installed!"
echo ""
echo "📝 Next steps:"
echo "  - Review symlinks: ls -la ~"
echo "  - Verify configurations loaded in new shell"
echo "  - Customize as needed"
