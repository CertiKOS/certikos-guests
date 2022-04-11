#!/bin/sh

qcow=$(realpath "$(find -name "*.qcow2")")

f_zip=$(find -name "*.7z.*")
rm $f_zip

7z a -V1g -aoa -bsp1 -mx=1 "${qcow}.7z" "$qcow"
