# Config

Requirements

```
git
stow
fish
```

## To install Fonts

```
fc-cache -fv
```

## Apps / Packages

### Flatpak

- firefox
- obsidian
- discord
- telegram

### DNF

- ghostty
- fish
- scrcpy
- stow
- code

### Other

- git, git-gui, gitk
- docker

## Setup texlive plp

1. `stow texlive` from this repo
2. check that `TEXMFAUXTREES` points to the texmf dir in plp repo
3. set `TEXMFCNF` variable to `$HOME/.config/texlive:`

```
❯ cd ~/.config/texlive
❯ cat texmf.cnf
TEXMFAUXTREES = /home/lauti/src/plp/texmf,
❯ set -Ux TEXMFCNF "$HOME/.config/texlive:"
```

4. install texlive packages

```
sudo dnf install texlive-lastpage texlive-xypic texlive-collection-mathscience texlive-epsf texlive-framed texlive-babel-spanish texlive-beamer texlive-lkproof
```
