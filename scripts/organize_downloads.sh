#!/bin/sh
# a script to organize the Downloads folder. It organizes files older than three days
# moving them into different directories.

if ! type fd >/dev/null 2>&1; then
  exit 1
fi

cd ~/Downloads || exit 1

# find and collect movies
mkdir -p ~/Downloads/Movies
fd --type file --change-older-than 3d --size="+700m" --exact-depth 1 -e mp4 -e mkv -e avi -X mv "{}" ~/Downloads/Movies

# find and collect videos
mkdir -p ~/Downloads/Videos
fd --type file --change-older-than 3d --size="-700m" --exact-depth 1 -e mp4 -e mkv -e avi -X mv "{}" ~/Downloads/Videos

# find and collect images
mkdir -p ~/Downloads/Pictures
fd --type file --change-older-than 3d --exact-depth 1 -e heic -e png -e jpg -e jpeg -e webp -e avif -X mv "{}" ~/Downloads/Pictures

# find and collect gifs
mkdir -p ~/Downloads/Gifs
fd --type file --change-older-than 3d --exact-depth 1 -e gif -e webm -X mv "{}" ~/Downloads/Gifs

# find and collect ebooks
mkdir -p ~/Downloads/Books
fd --type file --change-older-than 3d --exact-depth 1 -e epub -e mobi -e azw3 -X mv "{}" ~/Downloads/Books
