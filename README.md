# dotfiles

Manage dotfiles across macOS and Linux using [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Start

```bash
# Clone the repository
git clone git@github.com:jolilius/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Install all packages
./install.sh
```

Or install individual packages:
```bash
stow shell        # .zshrc, .bashrc, shell configuration
stow editor       # nvim, vim configuration
stow terminal     # kitty, ghostty, alacritty configuration
stow tools        # karabiner, aerospace, bat, starship, etc.
stow git          # git configuration
```

## Directory Structure

```
.dotfiles/
├── shell/        # Shell configuration (.zshrc, .bashrc)
├── editor/       # Editor config (.config/nvim, .vimrc)
├── terminal/     # Terminal emulators (.config/kitty, .config/ghostty, etc.)
├── tools/        # Tool configs (.config/karabiner, .config/aerospace, .config/starship.toml, etc.)
├── git/          # Git configuration (.config/git)
├── install.sh    # Automated installation script
└── README.md     # This file
```

## How Stow Works

GNU Stow creates symlinks from this directory to your home directory. For example:

- `shell/.zshrc` → `~/.zshrc`
- `editor/.config/nvim/init.lua` → `~/.config/nvim/init.lua`
- `tools/.config/starship.toml` → `~/.config/starship.toml`

### Unstalling a Package

To remove symlinks for a package:
```bash
stow -D shell     # Remove shell package
stow -D editor    # Remove editor package
```

## Setup on New Machine

1. Install `stow` if not already installed:
   ```bash
   # macOS
   brew install stow
   
   # Ubuntu/Debian
   sudo apt-get install stow
   ```

2. Clone and install:
   ```bash
   git clone git@github.com:jolilius/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ./install.sh
   ```

3. Start a new shell session to load the configurations

## Platform-Specific Setup

### macOS
Required tools:
- `stow` - for symlink management
- `homebrew` - for package management
- `antigen` - for zsh plugin management (referenced in `.zshrc`)

Install via Homebrew:
```bash
brew install stow antigen
```

### Linux (Ubuntu/Debian)
```bash
sudo apt-get install stow zsh
# Install antigen manually or via package manager
```

## Notes

- The `.zshrc` sources configuration from `~/.config/shell/` for shared settings
- Platform-specific overrides can be added via shell sourcing (see `.zshrc`)
- Secrets (SSH keys, API tokens) are managed separately—not included in this repo
- Large runtime databases (e.g., `~/.config/zotero-mcp`) are excluded

## Adding New Dotfiles

To add a new tool's config:

1. Create a package directory if needed:
   ```bash
   mkdir -p tools/.config/newtool
   ```

2. Copy the config file:
   ```bash
   cp ~/.config/newtool/config tools/.config/newtool/
   ```

3. Stow it:
   ```bash
   stow tools
   ```

4. Commit to git:
   ```bash
   git add tools/.config/newtool/
   git commit -m "Add newtool configuration"
   ```

## Troubleshooting

### Symlinks not created
- Check if files already exist in `~`: `ls -la ~/<filename>`
- Remove conflicting files: `rm ~/<filename>`
- Run `stow` again with verbose output: `stow -vv <package>`

### Wrong shell after install
- Change default shell: `chsh -s $(which zsh)`
- Restart terminal or source the profile: `source ~/.zshrc`

### stow command not found
- Install: `brew install stow` (macOS) or `sudo apt-get install stow` (Linux)
- Or use full path: `/usr/local/bin/stow` (if installed via Homebrew)
