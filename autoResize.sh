#!/bin/bash
if ! command -v convert &> /dev/null
then
    read -p "convert could not be found. Do you want to install it? [Y/n] " yn
    case $yn in
        [Yy]* ) sudo apt-get install -y imagemagick;;
        [Nn]* ) exit;;
        * ) echo "Please answer y [yes] or n [no]."; exit;;
    esac
fi
if [ $# -eq 0 ]; then
    echo "Format is $0 <path to image>"
    exit
fi
if [ ! -f $1 ]; then
    echo "File $1 does not exist"
    exit
fi

mkdir icons

resizes=( 512x512 192x192 180x180 32x32 16x16)

convert -resize x16 -gravity center -crop 16x16+0+0 $1 -flatten -colors 256 -background transparent icons/favicon.ico

for i in "${resizes[@]}"
do 
    :
    convert $1 -resize $i icons/$i-$1
done
