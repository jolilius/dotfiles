#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
    launchctl load -w ~/Library/LaunchAgents/com.qmd.update.plist
    launchctl load -w ~/Library/LaunchAgents/com.qmd.refresh.plist
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
