#!/bin/sh
#
# Author: Tommaso Amici
# This file contains ffmpeg utilities for common operations on videos
# All commands accept two arguments:
#   - $1: input file name
#   - $2: optional output file name, sane defaults are provided

# Converts given video to mp4
to_mp4() {
  OUT="${2:-$1}"
  ffmpeg -i "$1" -q:v 0 "$OUT.mp4"
}

# Removes sound from given video
remove_sound() {
  OUT="${2:-$1-nosound}"
  ffmpeg -i "$1" -c copy -an "$OUT.mp4"
}

# Encodes video with better settings
optimize_mp4() {
  OUT="${2:-$1-optimized}"
  ffmpeg -i "$1" -vcodec libx264 -crf 28 "$OUT.mp4"
}
