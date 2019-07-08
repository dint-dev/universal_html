/// Implements _dart:indexed_db_ in VM and Flutter. In browser, exports
/// _"dart:indexed_db"_.
library vm.indexed_db;

export 'src/indexed_db.dart'
    if (dart.library.indexed_db) 'src/_sdk/indexed_db.dart';
