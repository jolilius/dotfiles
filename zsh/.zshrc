# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.bin:$HOME/bin:/usr/local/bin:$PATH

# Prefer gsed over sed
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
#export LDFLAGS="-L/usr/local/opt/lapack/lib"
#export CPPFLAGS="-I/usr/local/opt/lapack/include"


# Add texlive-2022 stuff
export PATH="/usr/local/texlive/2022/bin/universal-darwin:$PATH"
export MANPATH="/usr/local/texlive/2022/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2022/texmf-dist/doc/info:$INFOPATH"

#
#eval "$(starship init zsh)"
#
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"  ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi  

export EDITOR='nvim'
export MERMAID_BIN='/usr/local/bin/mmdc'
export export LC_CTYPE="fi_FI.UTF-8"


# Neovim setup

export XDG_CONFIG_HOME="$HOME/.config"



source $(brew --prefix)/share/antigen/antigen.zsh



# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
#antigen bundle tmux
#antigen bundle tmuxinator
antigen bundle chucknorris
antigen bundle colorize
antigen bundle common-aliases
antigen bundle dircycle
antigen bundle dirhistory
# antigen bundle fzf
antigen bundle gitfast
antigen bundle history
antigen bundle zsh-history-substring-search
antigen bundle ripgrep
antigen bundle thefuck
antigen bundle iterm2
antigen bundle zsh-autosuggestions
antigen bundle zsh-syntax-highlighting
antigen bundle vi-mode
antigen bundle agkozak/zsh-z

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Powerlevel10k
antigen theme romkatv/powerlevel10k


# bunlde for oding
# antigen bundle ttscoff/doing

# Load the theme.
antigen theme robbyrussell

# Tell Antigen that you're done.
antigen apply


autoload -U compinit && compinit


# Disable git pager
GIT_PAGER=""

# Configuration for Kitty
#autoload -Uz compinit
#compinit
# Completion for kitty
#kitty + complete setup zsh | source /dev/stdin

# ZSH_TMUX_AUTOSTART=true

MERMAID_BIN="/usr/local/bin/mmdc"

alias cz=chezmoi
alias cze="chezmoi edit"
alias cza="chezmoi apply"
alias czev="chezmoi edit ~/.vimrc; chemzoi apply"

alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "WIP"'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh  ]] || source ~/.p10k.zsh

# Set vim mode
bindkey -v

# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
# eval "$(rbenv init - zsh)"


# Created by `pipx` on 2025-01-03 15:41:37
export PATH="$PATH:/Users/jolilius/.local/bin"
