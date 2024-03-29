#!/bin/bash
# Converts a photographed page from each page 1 of form 2611 (used by
# the Bear) into a photograph suitable for OCR.
#
# This does not include the OCR code itself. However, I've been
# feeding the raw base64 string into Google's Vision API here:
# https://cloud.google.com/vision/docs/ocr
#
# I tried other OCR tools, including GOCR and tesseract, even
# OpenALPR, and only Google's results have so far resulted in a
# suitable capture.
#
# Note that there are also minor page alignment differences between
# captures of these pages. If you do not get a good scan result, try
# updating the crop function below.
#
# Also note that even with one of the best OCR platforms available,
# there are still transcription errors to watch out for (for example,
# "1" replaced with "i", improper capitalization, and "c" characters
# frequently replaced with "e". Please consider these when writing
# downstream tooling that ingests the columnar output generated by
# each OCR capture.
#
# Also note that this deliberately does not OCR the hour number of
# each entry, since these were difficult to capture. The Bear evenly
# spaces these out over the course of each day.  To figure out the
# hour of an entry, multiply the current line number by (24 / total
# number of lines).
#
# Good luck, and happy parsing! :)

export WEATHER_SCRATCH_SPACE=/tmp/icewing-scratch

rm -f ${WEATHER_SCRATCH_SPACE} ${WEATHER_SCRATCH_SPACE}_cropped.pnm ${WEATHER_SCRATCH_SPACE}_converted.pnm ${WEATHER_SCRATCH_SPACE}_converted.jpg
curl $1 > ${WEATHER_SCRATCH_SPACE}
convert -crop 1100x1230+1530+830 ${WEATHER_SCRATCH_SPACE} ${WEATHER_SCRATCH_SPACE}_cropped.pnm
unpaper ${WEATHER_SCRATCH_SPACE}_cropped.pnm ${WEATHER_SCRATCH_SPACE}_converted.pnm
convert -quality 85% ${WEATHER_SCRATCH_SPACE}_converted.pnm ${WEATHER_SCRATCH_SPACE}_converted.jpg
base64 -w 0 ${WEATHER_SCRATCH_SPACE}_converted.jpg
