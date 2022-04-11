#!/bin/sh

f_zip=$(realpath "$(find -name "*.7z.001")")

7z e -aoa -bsp1 "${f_zip}"
