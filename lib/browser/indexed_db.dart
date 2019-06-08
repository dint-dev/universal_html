/// Exports _dart:indexed_db_. In VM and Flutter, exports our implementation.
library browser.indexed_db;

export 'dart:indexed_db' if (dart.library.io) '../indexed_db.dart';
