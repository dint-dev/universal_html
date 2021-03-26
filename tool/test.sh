#!/bin/sh

set -e
cd `dirname $0`/..

echo "----------------------------------------------------------------------------------------------------"
echo "Running: dart test"
echo "         (in directory 'test')"
echo "----------------------------------------------------------------------------------------------------"
dart pub get
dart test

echo "----------------------------------------------------------------------------------------------------"
echo "Running: flutter test"
echo "         (in directory 'test_in_flutter')"
echo "----------------------------------------------------------------------------------------------------"
cd test_in_flutter
flutter pub get
flutter test
flutter build web