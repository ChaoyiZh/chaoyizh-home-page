#!/usr/bin/env bash
# Build cv.tex with the TeX Live docker image and publish the PDF to the homepage.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
out="$(mktemp -d)"
docker run --rm -u "$(id -u):$(id -g)" -e HOME=/tmp \
  -v "$here":/src:ro -v "$out":/out -w /src texlive/texlive:latest \
  sh -c 'pdflatex -interaction=nonstopmode -halt-on-error -output-directory=/out cv.tex >/dev/null && pdflatex -interaction=nonstopmode -halt-on-error -output-directory=/out cv.tex | tail -2'
cp "$out/cv.pdf" "$here/../images/chaoyi/CV.pdf"
rm -rf "$out"
echo "updated images/chaoyi/CV.pdf"
