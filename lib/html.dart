library universal_html.html;

export 'src/html.dart' if (dart.library.html) 'dart:html'
    hide HtmlIsolate, HtmlDriver, NodeParserDriver, ZoneLocal;