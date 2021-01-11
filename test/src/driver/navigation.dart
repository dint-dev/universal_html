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

part of driver_test;

void _testNavigationNetworking() {
  group('Navigation:', () {
    HttpServer server;
    String receivedContentType;
    String receivedBody;
    setUpAll(() async {
      server = await HttpServer.bind('localhost', 0);
      server.listen((request) async {
        receivedContentType = request.headers.contentType?.value;
        receivedBody = await utf8.decodeStream(request);
        final response = request.response;
        switch (request.uri.path) {
          case 'form':
            response.statusCode = 200;
            break;

          default:
            response.statusCode = 404;
            break;
        }
        await response.close();
      });
    });

    test('Anchor click', () {
      final anchor = AnchorElement()..href = '/anchror_destination';
      anchor.click();
    });

    group('Form submission:', () {
      InputElement textInput;
      InputElement checkboxInput0;
      InputElement checkboxInput1;
      InputElement checkboxInput2;
      InputElement radioButtonInput0;
      InputElement radioButtonInput1;
      InputElement radioButtonInput2;
      InputElement submitButton;
      InputElement resetButton;
      FormElement formElement;
      String action;
      String formEncoding;
      String getUri;

      setUp(() {
        HtmlDriver.zoneLocal.defaultValue = HtmlDriver();
        formElement = FormElement();
        textInput = TextInputElement()
          ..name = 'k0'
          ..value = 'v0';
        checkboxInput0 = CheckboxInputElement()
          ..name = 'k1'
          ..value = 'v1-0';
        checkboxInput1 = CheckboxInputElement()
          ..name = 'k1'
          ..value = 'v1-1';
        checkboxInput2 = CheckboxInputElement()
          ..name = 'k1'
          ..value = 'v1-2';
        radioButtonInput0 = RadioButtonInputElement()
          ..name = 'k2'
          ..value = 'v2-0';
        radioButtonInput1 = RadioButtonInputElement()
          ..name = 'k2'
          ..value = 'v2-1';
        radioButtonInput2 = RadioButtonInputElement()
          ..name = 'k2'
          ..value = 'v2-2';
        submitButton = SubmitButtonInputElement();
        resetButton = ResetButtonInputElement();
        formElement = FormElement()
          ..append(textInput)
          ..append(checkboxInput0)
          ..append(checkboxInput1)
          ..append(checkboxInput2)
          ..append(radioButtonInput0)
          ..append(radioButtonInput1)
          ..append(radioButtonInput2)
          ..append(submitButton)
          ..append(resetButton);

        expect(textInput.type, 'text');
        expect(textInput.name, 'k0');
        expect(textInput.value, 'v0');

        expect(checkboxInput0.type, 'checkbox');
        expect(checkboxInput0.name, 'k1');
        expect(checkboxInput0.value, 'v1-0');
        expect(checkboxInput0.checked, isFalse);

        expect(radioButtonInput0.type, 'radio');
        expect(radioButtonInput0.name, 'k2');
        expect(radioButtonInput0.value, 'v2-0');
        expect(radioButtonInput0.checked, isFalse);

        // Try repeated clicks on checkbox
        checkboxInput0.click();
        expect(checkboxInput0.checked, isTrue);
        checkboxInput0.click();
        expect(checkboxInput0.checked, isFalse);

        // Select first two checkboxes
        checkboxInput0.click();
        checkboxInput1.click();

        // Check state
        expect(checkboxInput0.checked, isTrue);
        expect(checkboxInput1.checked, isTrue);
        expect(checkboxInput2.checked, isFalse);

        // Select first radiobutton
        radioButtonInput0.click();

        // No, let's select the second
        radioButtonInput1.click();

        // Check state of all inputs
        expect(textInput.value, 'v0');
        expect(checkboxInput0.type, 'checkbox');
        expect(checkboxInput0.name, 'k1');
        expect(checkboxInput0.value, 'v1-0');
        expect(checkboxInput0.checked, isTrue);
        expect(checkboxInput1.checked, isTrue);
        expect(checkboxInput2.checked, isFalse);
        expect(radioButtonInput0.type, 'radio');
        expect(radioButtonInput0.name, 'k2');
        expect(radioButtonInput0.value, 'v2-0');
        expect(radioButtonInput0.checked, isFalse);
        expect(radioButtonInput1.checked, isTrue);
        expect(radioButtonInput2.checked, isFalse);

        action = 'http://localhost:${server.port}/form';
        formEncoding = 'k0=v0&k1=v1-0&k1=v1-1&k2=v2-1';
        getUri = action + '?' + formEncoding;
      });

      test('No action', () async {
        formElement.submit();
        await Future.delayed(Duration(milliseconds: 100));
        expect(window.location.href, HtmlDriver.defaultUri.toString());
      });

      test('SubmitButtonInputElement click', () async {
        expect(window.location.href, HtmlDriver.defaultUri.toString());
        formElement.method = 'GET';
        formElement.action = action;
        submitButton.click();
        await Future.delayed(Duration(milliseconds: 100));
        expect(window.location.href, getUri);
      });

      test('method="GET" action="/form"', () async {
        expect(window.location.href, HtmlDriver.defaultUri.toString());
        formElement.method = 'GET';
        formElement.action = action;
        formElement.submit();
        await Future.delayed(Duration(milliseconds: 100));
        expect(window.location.href, getUri);
        expect(receivedContentType, null);
        expect(receivedBody, '');
      });

      test('method="get" action="/form"', () async {
        expect(window.location.href, HtmlDriver.defaultUri.toString());
        formElement.method = 'get';
        formElement.action = action;
        formElement.submit();
        await Future.delayed(Duration(milliseconds: 100));
        expect(window.location.href, getUri);
        expect(receivedContentType, null);
        expect(receivedBody, '');
      });

      test('method="POST" action="/form"', () async {
        formElement.method = 'POST';
        formElement.action = action;
        formElement.submit();
        await Future.delayed(Duration(milliseconds: 100));
        expect(window.location.href, action);
        expect(receivedContentType, 'application/x-www-form-urlencoded');
        expect(receivedBody, formEncoding);
      });

      test('method="post" action="/form"', () async {
        formElement.method = 'post';
        formElement.action = action;
        formElement.submit();
        await Future.delayed(Duration(milliseconds: 100));
        expect(window.location.href, action);
        expect(receivedContentType, 'application/x-www-form-urlencoded');
        expect(receivedBody, formEncoding);
      });
    });
  });
}
