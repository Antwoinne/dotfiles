# ─────────────────────────────────────────────────────────────
#  ~/.zshrc — chef's kiss terminal config
#  Managed via: https://github.com/Antwoinne/dotfiles
# ─────────────────────────────────────────────────────────────

# ── PATH ─────────────────────────────────────────────────────
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.docker/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# ── History ──────────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS

# ── Completion ───────────────────────────────────────────────
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ── Aliases ──────────────────────────────────────────────────
alias ls='eza --icons --group-directories-first'
alias ll='eza -lahF --icons --git'
alias la='eza -a --icons'
alias tree='eza --tree --icons --level=3'
alias cat='bat --style=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'

# ── Key bindings ─────────────────────────────────────────────
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ── Prompt (Starship) ────────────────────────────────────────
eval "$(starship init zsh)"

# ── Plugins (Homebrew) ───────────────────────────────────────
[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
