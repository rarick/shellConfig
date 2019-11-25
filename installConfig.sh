#!/bin/bash

print_usage () {
  cat << EOF

Usage: installConfig.sh [options...]

Options:
  -h: Display this usage message and exit
  -i: Install required packages

EOF

}

install_packages () {
  sudo apt-get install tmux vim ranger

  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

# Get input arguments
while getopts ":hi" opt; do
  case $opt in
    h)
      print_usage
      exit 0
      ;;
    i)
      install_packages
      exit 0
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

echo -n "Installing tmux configuration...  "
tmux source-file ~/.tmux.conf
echo "Done."

echo -n "Installing vim plugins...  "
vim +PlugUpdate +PlugInstall +PlugClean +qall
echo "Done."
