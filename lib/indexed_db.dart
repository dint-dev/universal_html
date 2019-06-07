/// A version of 'dart:indexed_db' that works in all platforms.
library universal_html.indexed_db;

export 'src/indexed_db.dart' if (dart.library.indexed_db) 'dart:indexed_db';
