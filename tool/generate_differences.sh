#!/bin/sh

set -e
cd `dirname $0`/..

echo "----------------------------------------------------------------------------------------------------"
echo "Generating reflection data project"
echo "----------------------------------------------------------------------------------------------------"

cd test_data_generator
dart pub get
dart run build_runner build
cd ..

echo "----------------------------------------------------------------------------------------------------"
echo "Generating 'test/reflection_data.dart'"
echo "----------------------------------------------------------------------------------------------------"

mv test_data_generator/web/main-generated-data.dart test/reflection_data.dart

echo "----------------------------------------------------------------------------------------------------"
echo "Generating DIFFERENCES.md"
echo "----------------------------------------------------------------------------------------------------"

dart run tool/generate_differences.dart