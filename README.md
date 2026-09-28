# dotfiles

Personal terminal & shell config. One command to set up any Mac.

## Quick Setup (new machine)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Antwoinne/dotfiles/main/bootstrap.sh)"
```

## What's Included

| File | Purpose |
|---|---|
| `.zshrc` | Shell config — aliases, history, keybinds, plugins, Starship |
| `.config/starship.toml` | Prompt theme (Catppuccin Mocha) |
| `.gitconfig` | Git config with delta as diff pager |
| `Brewfile` | Declarative list of all packages/apps |
| `iterm2/` | iTerm2 color scheme |
| `bootstrap.sh` | Automated setup script |

## Updating

Edit files here, then:

```bash
cd ~/dotfiles && git add -A && git commit -m "update" && git push
```

On other machines:
```bash
cd ~/dotfiles && git pull
```

Symlinks mean changes take effect immediately (restart terminal or `source ~/.zshrc`).
