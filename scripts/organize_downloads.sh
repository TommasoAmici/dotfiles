#!/bin/sh
# a script to organize the Downloads folder. It organizes files older than three days
# moving them into different directories.

if ! type fd >/dev/null 2>&1; then
  exit 1
fi

cd ~/Downloads || exit 1

# find and collect movies
mkdir -p ~/Downloads/Movies
fd --type file --change-older-than 3d --size="+700m" --exact-depth 1 -e mp4 -e mkv -e avi \
  --exec-batch mv "{}" ~/Downloads/Movies

# find and collect videos
mkdir -p ~/Downloads/Videos
fd --type file --change-older-than 3d --size="-700m" --exact-depth 1 -e mp4 -e mkv -e avi \
  --exec-batch mv "{}" ~/Downloads/Videos

# find and collect images
mkdir -p ~/Downloads/Pictures/DALL·E
fd "DALL·E" --type file --change-older-than 3d --exact-depth 1 \
  --exec-batch mv "{}" ~/Downloads/Pictures/DALL·E
fd --type file --change-older-than 3d --exact-depth 1 -e heic -e png -e jpg -e jpeg -e webp -e avif -e nef \
  --exec-batch mv "{}" ~/Downloads/Pictures

# find and collect gifs
mkdir -p ~/Downloads/Gifs
fd --type file --change-older-than 3d --exact-depth 1 -e gif -e webm \
  --exec-batch mv "{}" ~/Downloads/Gifs

# find and collect all things graphics: photoshop, sketch, svg, etc
mkdir -p ~/Downloads/Graphics
fd --type file --change-older-than 3d --exact-depth 1 -e svg -e psd -e sketch -e eps \
  --exec-batch mv "{}" ~/Downloads/Graphics

# find and collect presentations
mkdir -p ~/Downloads/Presentations
fd --type file --change-older-than 3d --exact-depth 1 --size="+1m" -e key -e kth -e ppt \
  --exec-batch mv "{}" ~/Downloads/Presentations
fd "slides|presentation" --type file --change-older-than 3d --exact-depth 1 -e pdf \
  --exec-batch mv "{}" ~/Downloads/Presentations

# find and collect ebooks
mkdir -p ~/Downloads/Books
fd --type file --change-older-than 3d --exact-depth 1 -e epub -e mobi -e azw3 \
  --exec-batch mv "{}" ~/Downloads/Books

fd --type file --change-older-than 3d --exact-depth 1 -e pdf \
  --exec sh ~/dotfiles/scripts/_organize_downloads_find_pdf_books.sh

# find and collect invoices, order confirmations, etc
mkdir -p ~/Downloads/Invoices
fd "\border|invoice" --type file --change-older-than 3d --exact-depth 1 -e pdf \
  --exec-batch mv "{}" ~/Downloads/Invoices

# find and collect bibtex entries
mkdir -p ~/Downloads/References
fd --type file --change-older-than 3d --exact-depth 1 -e bib \
  --exec-batch mv "{}" ~/Downloads/References
