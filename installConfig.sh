#!/bin/bash

print_usage () {
  cat << EOF

Usage: installConfig.sh [options...]

Options:
  -h: Display this usage message and exit
  -i: Install required packages
  -p: Install and update plugins

EOF

}


TPM_DIR=~/.tmux/plugins/tpm

install_packages () {
  sudo apt-get install tmux vim ranger

  git clone https://github.com/tmux-plugins/tpm $TPM_DIR
}


update_plugins () {
  echo "Installing tmux configuration...  "
  tmux source-file ~/.tmux.conf
  $TPM_DIR/bin/update_plugins
  $TPM_DIR/bin/install_plugins
  $TPM_DIR/bin/clean_plugins
  echo "Done."

  echo -n "Installing vim plugins...  "
  vim +PlugUpdate +PlugInstall +PlugClean +qall
  echo "Done."
}


# Get input arguments
while getopts ":hip" opt; do
  case $opt in
    h)
      print_usage
      exit 0
      ;;
    i)
      install_packages
      ;;
    p)
      update_plugins
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      print_usage
      exit 1
      ;;
  esac
done

DATA_DIR=$(dirname "$0")/data
HOME_DATA_DIR=$DATA_DIR/home

# Input configuration files
echo -n "Copying files to home...  "
shopt -s dotglob nullglob
cp -r $HOME_DATA_DIR/* ~
echo "Done."
