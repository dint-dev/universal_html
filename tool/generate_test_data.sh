#!/bin/sh

set -e
cd `dirname $0`/..

echo "----------------------------------------------------------------------------------------------------"
echo "Generating reflection data"
echo "----------------------------------------------------------------------------------------------------"

cd test_data_generator

dart pub get

dart run build_runner build

cd ..

DEST="test/reflection_data.dart"

echo "Copying to $DEST"

mv test_data_generator/web/main-generated-data.dart "$DEST"
