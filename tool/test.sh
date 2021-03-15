#!/bin/sh

set -e
cd `dirname $0`/..
echo "----------------------------------------------------------------------------------------------------"
echo "Starting test server"
echo "----------------------------------------------------------------------------------------------------"
dart pub get
dart run test/network_apis_testing_server.dart &
PID=$!
killServer () {
  kill "$PID"
}

echo "----------------------------------------------------------------------------------------------------"
echo "Running: dart test"
echo "         (in directory 'test')"
echo "----------------------------------------------------------------------------------------------------"
(dart test) || killServer

echo "----------------------------------------------------------------------------------------------------"
echo "Running: flutter test"
echo "         (in directory 'test_in_flutter')"
echo "----------------------------------------------------------------------------------------------------"
cd test_in_flutter
(flutter pub get) || killServer
(flutter test) || killServer
cd ..