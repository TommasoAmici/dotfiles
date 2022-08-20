#!/bin/sh

NUM_PAGES=$(pdfinfo "$1" | awk '/^Pages:/ {print $2}')
if [ "$NUM_PAGES" -gt 100 ]; then
  mv "$1" ~/Downloads/Books
fi
