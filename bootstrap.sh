#!/bin/bash
set -euo pipefail

DOTFILES_REPO="https://github.com/Antwoinne/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

echo ""
echo "🚀 Setting up this Mac..."
echo ""

# ── 1. Install Homebrew if missing ──
if ! command -v brew &>/dev/null; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ── 2. Clone or update dotfiles ──
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "📂 Cloning dotfiles..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  echo "📂 Updating dotfiles..."
  git -C "$DOTFILES_DIR" pull --rebase
fi

# ── 3. Install everything from Brewfile ──
echo "🍺 Installing packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# ── 4. Symlink config files ──
echo "🔗 Linking config files..."

ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# Only link .gitconfig sections (preserve machine-specific git config)
# We add includes instead of overwriting .gitconfig entirely
if ! grep -q "dotfiles/.gitconfig" "$HOME/.gitconfig" 2>/dev/null; then
  git config --global include.path "$DOTFILES_DIR/.gitconfig"
fi

mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

# ── 5. Import iTerm2 color scheme ──
if [ -f "$DOTFILES_DIR/iterm2/catppuccin-mocha.itermcolors" ]; then
  echo "🎨 Importing iTerm2 color scheme..."
  open "$DOTFILES_DIR/iterm2/catppuccin-mocha.itermcolors" 2>/dev/null || true
fi

# ── 6. Set iTerm2 to load prefs from dotfiles ──
if [ -d "/Applications/iTerm.app" ]; then
  defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$DOTFILES_DIR/iterm2"
  defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
fi

echo ""
echo "✅ Done! Quit and reopen your terminal (or open iTerm2)."
echo ""
echo "📝 Don't forget:"
echo "   • In iTerm2 → Settings → Profiles → Text → Font → 'MesloLGS Nerd Font'"
echo "   • In iTerm2 → Settings → Profiles → Colors → Color Presets → 'catppuccin-mocha'"
echo ""
