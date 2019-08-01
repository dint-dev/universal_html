// Copyright 2019 terrier989@gmail.com
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
/// Exports _dart:indexed_db_. In VM and Flutter, exports our implementation.

/// {@nodoc}
@Deprecated(
    "Use 'package:universal_html/prefer_sdk/indexed_db.dart', which is more descriptive.")
library browser.indexed_db;

export 'dart:indexed_db' if (dart.library.io) '../indexed_db.dart';
