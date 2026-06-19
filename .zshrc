setopt autocd
export EDITOR=nvim

if [[ $- == *i* ]]; then

  # Set the directory we want to store zinit and plugins
  ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

  # Download Zinit, if it's not there yet
  if [ ! -d "$ZINIT_HOME" ]; then
     mkdir -p "$(dirname $ZINIT_HOME)"
     git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
  fi

  # Source/Load zinit
  source "${ZINIT_HOME}/zinit.zsh"

  # Add in zsh plugins
  zinit light zsh-users/zsh-syntax-highlighting
  zinit light zsh-users/zsh-completions
  zinit light zsh-users/zsh-autosuggestions
  zinit light Aloxaf/fzf-tab
  zinit snippet OMZL::key-bindings.zsh
  zinit ice depth=1
  zinit light jeffreytse/zsh-vi-mode

  # Add in snippets
  zinit snippet OMZP::git
  zinit snippet OMZP::sudo
  plugins=(symfony)
  zstyle :compinstall filename "${HOME}/.zshrc"
  autoload -Uz compinit
  compinit

  bindkey '^p' history-search-backward
  bindkey '^n' history-search-forward
  bindkey '^[w' kill-region

  zle_highlight+=(paste:none)

  # History
  HISTSIZE=5000
  HISTFILE=~/.zsh_history
  SAVEHIST=$HISTSIZE
  HISTDUP=erase
  setopt appendhistory
  setopt sharehistory
  setopt hist_ignore_space
  setopt hist_ignore_all_dups
  setopt hist_save_no_dups
  setopt hist_ignore_dups
  setopt hist_find_no_dups

  # Completion styling
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
  zstyle ':completion:*' menu no
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
  zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

  alias ll='ls -alh'
  alias vim='nvim'

  # Shell integrations
  eval "$(fzf --zsh)"
  eval "$(zoxide init --cmd cd zsh)"
  if command -v oh-my-posh >/dev/null 2>&1; then
    eval "$(oh-my-posh init zsh --config ~/zsh/catppuccin_frappe.omp.json)"
  fi
fi


# opencode
export PATH="$HOME/.opencode/bin:$PATH"
