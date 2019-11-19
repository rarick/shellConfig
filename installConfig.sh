#!/bin/bash

print_usage () {
  cat << EOF

Usage: installConfig.sh [-h]
  -h: Display this usage message

EOF

}

# Get input arguments
while getopts ":h" opt; do
  case $opt in
    h)
      print_usage
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
echo -n "Copying files to home... "
shopt -s dotglob nullglob
cp -r $HOME_DATA_DIR/* ~
echo "Done."

echo -n "Installing tmux configuration... "
tmux source-file ~/.tmux.conf
echo "Done."

echo -n "Installing vim plugins... "
vim +PlugUpdate +PlugInstall +PlugClean +qall
echo "Done."
