#!/bin/sh

# Exit on error
set -e

cd `dirname $0`/..

./tool/generate_reflection.sh
echo ""
echo ""
./tool/generate_differences.sh
echo ""
echo ""
echo "----------------------------------------------------------------------------------------------------"
echo "Running tests"
echo "----------------------------------------------------------------------------------------------------"
pub run test
