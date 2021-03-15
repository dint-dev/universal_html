import 'dart:math';
import 'dart:typed_data';

import 'package:universal_io/io.dart' as io;

class MultipartFormWriter {
  static final _random = Random.secure();
  final io.HttpClientRequest sink;

  late String _boundary;

  MultipartFormWriter(this.sink) {
    _boundary = _randomBoundary();
  }

  String get boundary => _boundary;

  void close() {
    sink.close();
  }

  void writeBoundary() {
    sink.write(_boundary);
  }

  void writeContentDisposition(io.ContentType contentType) {
    writeHeader('Content-Disposition', contentType.value);
  }

  void writeFieldValue(String name, String value) {
    final parameters = <String, String>{
      'name': name,
    };
    writeContentDisposition(io.ContentType(
      'text',
      'plain',
      parameters: parameters,
    ));
    sink.writeln();
    sink.writeln(value);
    sink.writeln();
    writeBoundary();
    sink.writeln();
  }

  void writeFile(String name, Uint8List value, {String? fileName}) {
    final parameters = <String, String>{
      'name': name,
    };
    fileName ??= '';
    if (fileName != '') {
      parameters['filename'] = fileName;
    }
    writeContentDisposition(io.ContentType(
      'application',
      'octet-stream',
      parameters: parameters,
    ));
    sink.writeln();
    sink.add(value);
    sink.writeln();
    writeBoundary();
    sink.writeln();
  }

  void writeHeader(String name, String value) {
    sink.writeln('$name: $value');
  }

  static String _randomBoundary() {
    final sb = StringBuffer();
    sb.write('----');
    for (var i = 0; i < 32; i++) {
      sb.write(_random.nextInt(256).toRadixString(16).padLeft(2, '0'));
    }
    return sb.toString();
  }
}
