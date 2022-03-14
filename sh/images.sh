#!/bin/sh

# Resizes the given image to the given size.
# The resized image will be in a newly created `resized` directory.
# Optionally optimizes images with @funboxteam/optimizt if npx is installed
# Usage: `resize_image 256 image.png`
resize_image() {
  SIZE=$1
  FILE=$2
  sips --out ./resized/ --resampleHeightWidthMax "$SIZE" "$FILE"
  log_success "Resized $FILE"

  if type npx >/dev/null 2>&1; then
    if echo "$FILE" | grep -q "opacity"; then
      log_error "Don't optimize opacity maps"
    else
      npx @funboxteam/optimizt "./resized/$FILE"
    fi
  fi
}

# A function to resize all .jpg and .png images in a directory
# It takes one parameter passed to `sips --resampleHeightWidthMax`
# Usage: `resize_images 500`
resize_images() {
  SIZE=$1
  mkdir resized || true
  for FILE in *.png; do
    resize_image "$SIZE" "$FILE"
  done

  for FILE in *.jpg; do
    resize_image "$SIZE" "$FILE"
  done
}

# Converts the given PDF to PNG.
# Optionally optimizes images with @funboxteam/optimizt if npx is installed
# Usage: `pdf_to_png file.pdf`
pdf_to_png() {
  FILE=$1
  if ! (echo "$FILE" | grep -q ".pdf"); then
    log_error "$FILE is not a PDF"
    return
  fi

  FILENAME=$(basename "$FILE" .pdf)
  OUTPUT="$FILENAME.png"
  sips --setProperty format png "$FILE" --out "$OUTPUT"

  if type npx >/dev/null 2>&1; then
    npx @funboxteam/optimizt "$OUTPUT"
  fi
}
