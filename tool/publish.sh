#!/bin/sh

# Exit on error
set -e

PUBLISHED=published

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
if [ -e $PUBLISHED ]; then
  echo "Deleting '$DIR'."
  rm -R $PUBLISHED/
fi
mkdir -p $PUBLISHED/ || exit
echo "Copying files to '$PUBLISHED'."
cp -R .gitignore LICENSE *.md pubspec.yaml analysis_options.yaml dart_test.yaml example lib test $PUBLISHED/
cd $PUBLISHED/
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
cd ..
rm -R $PUBLISHED/