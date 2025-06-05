#!/bin/bash
set -e
BACKENDS="text hdf5 s3"

# Check that script is executed from tools directory
if [[ $(basename $PWD) != "tools" ]] ; then
  echo "This script should run in the tools directory"
  exit -1
fi

TREXIO_ROOT=$(dirname "${PWD}../")

#   First define readonly global variables.
readonly SRC=${TREXIO_ROOT}/src
readonly TOOLS=${TREXIO_ROOT}/tools

# Function to produce TREXIO source files from org-mode files
function tangle()
{
  local command="(org-babel-tangle-file \"$1\")"
  emacs --batch \
        --load=${TOOLS}/emacs/config_tangle.el \
        --eval "$command" &> /dev/null
}
#        --eval "(require 'org)" \
#        --eval "(org-babel-do-load-languages 'org-babel-load-languages '((python . t)))" \
#        --eval "(setq org-confirm-babel-evaluate nil)" \

# Go to src directory
cd ${SRC}

# We want the script to crash on the 1st error:
set -e

# Create directories for templates
echo "create populated directories"
mkdir -p templates_front/populated
for B in $BACKENDS ; do
  mkdir -p templates_$B/populated
done

# It is important to ad '--' to rm because it tells rm that what follows are
# not options. It is safer.

# Cleaning of existing data
echo "remove existing templates"
rm -f -- templates_front/*.{c,h,f90}
for B in $BACKENDS ; do
    rm -f -- templates_$B/*.{c,h}
done

echo "clean populated directories"
rm -f -- templates_front/populated/*
for B in $BACKENDS ; do
  rm -f -- templates_$B/populated/*
done
echo "tangle org files to generate templates"
cd templates_front
tangle templator_front.org
cd ..

# Produce source files for back ends
for B in $BACKENDS ; do
  cd templates_$B
  tangle templator_$B.org &
  cd ..
done
wait

# Produce source files for S3 back end
cd templates_s3
tangle templator_s3.org
cd ..

# Populate templates with TREXIO structure according to trex.json file
echo "run generator script to populate templates"
cp ${TOOLS}/generator.py ${TOOLS}/generator_tools.py ${SRC}
python3 generator.py
rm -f -- ${SRC}/generator.py ${SRC}/generator_tools.py
rm -f -r -- ${SRC}/__pycache__/

# Put pieces of source files together
echo "compile populated files in the lib source files "
cd templates_front
source build.sh
cp trexio* ../
cd ..
mv trexio.h trexio_f.f90 ../include

for B in $BACKENDS ; do
  cd templates_$B
  source build.sh
  cp trexio* ../
  cd ..
done

