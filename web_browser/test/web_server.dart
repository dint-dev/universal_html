import 'dart:io';

Future<void> main() async {
  final server = await HttpServer.bind('localhost', 9898);
  server.listen((request) {
    final response = request.response;
    try {
      response.write('Hello!');
    } finally {
      response.close();
    }
  });
}
