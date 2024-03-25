import 'package:universal_html/html.dart';

void main() {
  // Create a DOM tree
  final divElement = DivElement();
  divElement.append(Element.tag('h1')
    ..classes.add('greeting')
    ..appendText('Hello world!'));

  // Print outer HTML
  print(divElement.outerHtml);
  // --> <div><h1>Hello world</h1></div>

  // Do a CSS query
  print(divElement.querySelector('div > .greeting')!.text);
  // --> Hello world

  final broadcastChannel = BroadcastChannel('Channel_Name');
  broadcastChannel.onMessage.listen((event) {
    print(event);
  });
}
