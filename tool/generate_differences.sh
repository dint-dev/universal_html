#!/bin/sh

set -e
cd `dirname $0`/..

echo "----------------------------------------------------------------------------------------------------"
echo "Generating reflection data project"
echo "----------------------------------------------------------------------------------------------------"

cd tool/generate_reflection
pub get --offline
pub run build_runner build
cd ../..

echo "----------------------------------------------------------------------------------------------------"
echo "Running: dartmft --fix -w tool/generate_reflection/"
echo "----------------------------------------------------------------------------------------------------"

dartfmt --fix -w tool/generate_reflection/

echo "----------------------------------------------------------------------------------------------------"
echo "Generating 'test/reflection_data.dart'"
echo "----------------------------------------------------------------------------------------------------"

mv tool/generate_reflection/web/main-generated-data.dart test/reflection_data.dart

echo "----------------------------------------------------------------------------------------------------"
echo "Generating DIFFERENCES.md"
echo "----------------------------------------------------------------------------------------------------"

pub run tool/generate_differences.dart