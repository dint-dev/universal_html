#!/bin/sh

# Exit on error
set -e

TMP=tmp
DIR=$TMP/published

cd `dirname $0`/..

# ----
# Test
# ----
./tool/presubmit.sh


echo ""
echo ""
echo "----------------------------------------------------------------------------------------------------"
echo "Preparing to publish"
echo "----------------------------------------------------------------------------------------------------"
if [ -e $DIR ]; then
  echo "Deleting '$DIR'."
  rm -R $DIR
fi
mkdir -p $DIR || exit
echo "Copying files to '$DIR'."
cp -R .gitignore LICENSE *.md pubspec.yaml analysis_options.yaml dart_test.yaml example lib test $DIR/
cd $DIR
pub get --offline


echo ""
echo ""
echo "----------------------------------------------------------------------------------------------------"
echo "Publishing"
echo "----------------------------------------------------------------------------------------------------"
pub publish


echo ""
echo ""
echo "----------------------------------------------------------------------------------------------------"
echo "Removing temporary files"
echo "----------------------------------------------------------------------------------------------------"
read -s -p "Press [enter] to delete the temporary files"
rm -R $TMP