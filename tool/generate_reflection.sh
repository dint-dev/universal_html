#!/bin/sh

# Exit on error
set -e

echo "----------------------------------------------------------------------------------------------------"
echo "Generating reflection data"
echo "----------------------------------------------------------------------------------------------------"

HELPER_DIR=`dirname $0`/generate_reflection
cd $HELPER_DIR

pub get --offline

pub run build_runner build

cd ../..

DEST="test/reflection_data.dart"

echo "Copying to $DEST"

mv $HELPER_DIR/web/main-generated-data.dart $DEST
