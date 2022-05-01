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
  OUT="${2:-nosound-$1}"
  ffmpeg -i "$1" -c copy -an "$OUT"
}

# Encodes video with better settings
optimize_mp4() {
  OUT="${2:-$1-optimized}"
  ffmpeg -i "$1" -vcodec libx264 -crf 28 "$OUT.mp4"
}

# Extracts a clip of length $2, starting from $1
# Usage: extract_clip hh:mm:ss hh:mm:ss input [output]
# Example: extract_clip 00:04:59 00:00:11 input.mp4 [output.mp4]
extract_clip() {
  START="$1"
  LENGTH="$2"
  INPUT="$3"
  OUT="${4:-clip-$INPUT}"
  ffmpeg -ss "$START" -i "$INPUT" -t "$LENGTH" -c copy "$OUT"
}
