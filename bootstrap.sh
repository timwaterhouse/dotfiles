#!/usr/bin/env bash

# Get current dir (so this script can be run from anywhere)
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

git pull origin master;

function doIt() {
  files=(.aliases .bash_profile .bash_prompt .bashrc .exports .functions \
    .gitconfig .gitignore .inputrc .tmux.conf .vimrc)
  for f in "${files[@]}"
  do
    # Copy for Windows, symlink otherwise
    if [[ $OSTYPE == "msys" || $OSTYPE == "cygwin" ]] ;then
      cp -v "$DOTFILES_DIR/$f" ~
    else
      ln -sfv "$DOTFILES_DIR/$f" ~
    fi
  done
  mkdir -pv ~/.vim/backups
  mkdir -pv ~/.vim/swaps
  mkdir -pv ~/.vim/undo
  mkdir -pv ~/.config/nvim
  if [[ $OSTYPE == "msys" || $OSTYPE == "cygwin" ]] ;then
    cp -v "$DOTFILES_DIR/init.vim" ~/.config/nvim
  else
    ln -sfv "$DOTFILES_DIR/init.vim" ~/.config/nvim
  fi
  source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt;
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
  fi;
fi;
unset doIt;

