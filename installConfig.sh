#!/bin/bash

print_usage () {
    echo "Usage: installConfig.sh [-h]
        -h    Display this usage message"
}

# Get input arguments
while getopts ":h" opt; do
    case $opt in
        h)
            print_usage
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            print_usage
            exit 1
            ;;
    esac
done

DATA_DIR=$(dirname "$0")/data
ETC_DIR=$DATA_DIR/etc
HOME_DIR=$DATA_DIR/home

# Input configuration files
echo -n "Copying files to home... "
shopt -s dotglob nullglob
cp -r $HOME_DIR/* ~
echo "Done."

echo -n "Copying files to etc... "
sudo cp $ETC_DIR/* /etc
echo "Done."
