/// Implements _dart:svg_ in VM and Flutter. In browser, exports _"dart:svg"_.
library vm.svg;

export 'src/svg.dart' if (dart.library.svg) 'src/_sdk/svg.dart';
