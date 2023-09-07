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
/*
Some source code in this file was adopted from 'dart:html' in Dart SDK. See:
  https://github.com/dart-lang/sdk/tree/master/tools/dom

The source code adopted from 'dart:html' had the following license:

  Copyright 2012, the Dart project authors. All rights reserved.
  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

part of universal_html.internal;

/// A client-side XHR request for getting data from a URL,
/// formally known as XMLHttpRequest.
///
/// HttpRequest can be used to obtain data from HTTP and FTP protocols,
/// and is useful for AJAX-style page updates.
///
/// The simplest way to get the contents of a text file, such as a
/// JSON-formatted file, is with [getString].
/// For example, the following code gets the contents of a JSON file
/// and prints its length:
///
///     var path = 'myData.json';
///     HttpRequest.getString(path)
///         .then((String fileContents) {
///           print(fileContents.length);
///         })
///         .catchError((Error error) {
///           print(error.toString());
///         });
///
/// ## Fetching data from other servers
///
/// For security reasons, browsers impose restrictions on requests
/// made by embedded apps.
/// With the default behavior of this class,
/// the code making the request must be served from the same origin
/// (domain name, port, and application layer protocol)
/// as the requested resource.
/// In the example above, the myData.json file must be co-located with the
/// app that uses it.
/// You might be able to
/// [get around this restriction](http://www.dartlang.org/articles/json-web-service/#a-note-on-cors-and-httprequest)
/// by using CORS headers or JSONP.
///
/// ## Other resources
///
/// * [Fetch Data Dynamically](https://www.dartlang.org/docs/tutorials/fetchdata/),
/// a tutorial from _A Game of Darts_,
/// shows two different ways to use HttpRequest to get a JSON file.
/// * [Get Input from a Form](https://www.dartlang.org/docs/tutorials/forms/),
/// another tutorial from _A Game of Darts_,
/// shows using HttpRequest with a custom server.
/// * [Dart article on using HttpRequests](http://www.dartlang.org/articles/json-web-service/#getting-data)
/// * [JS XMLHttpRequest](https://developer.mozilla.org/en-US/docs/DOM/XMLHttpRequest)
/// * [Using XMLHttpRequest](https://developer.mozilla.org/en-US/docs/DOM/XMLHttpRequest/Using_XMLHttpRequest)
class HttpRequest extends HttpRequestEventTarget {
  /// Static factory designed to expose `readystatechange` events to event
  /// handlers that are not necessarily instances of [HttpRequest].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> readyStateChangeEvent =
      EventStreamProvider<Event>('readystatechange');

  static const int DONE = 4;

  static const int HEADERS_RECEIVED = 2;

  static const int LOADING = 3;

  static const int OPENED = 1;

  static const int UNSENT = 0;

  /// Checks to see if the current platform supports making cross origin
  /// requests.
  ///
  /// Note that even if cross origin requests are supported, they still may fail
  /// if the destination server does not support CORS requests.
  static bool get supportsCrossOrigin {
    return true;
  }

  /// Checks to see if the LoadEnd event is supported on the current platform.
  static bool get supportsLoadEndEvent {
    return false;
  }

  /// Checks to see if the overrideMimeType method is supported on the current
  /// platform.
  static bool get supportsOverrideMimeType {
    return true;
  }

  /// Checks to see if the Progress event is supported on the current platform.
  static bool get supportsProgressEvent {
    return false;
  }

  String? _requestMethod;

  Uri? _requestUrl;

  final Map<String, String> _requestHeaders = {};

  int? _status;

  String? _statusText;

  final Map<String, String> _responseHeaders = {};

  Uint8List? _responseData;

  int _readyState = UNSENT;

  int _requestId = 0;

  final _readyStateStreamController = StreamController<Event>();

  /// [String] telling the server the desired response format.
  ///
  /// Default is `text`.
  ///
  /// Options are one of 'arraybuffer', 'blob', 'document', 'json',
  /// 'text'. Some newer browsers will throw NS_ERROR_DOM_INVALID_ACCESS_ERR if
  /// `responseType` is set while performing a synchronous request.
  ///
  /// See also: [MDN
  /// responseType](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest#xmlhttprequest-responsetype)
  String responseType = 'text';

  /// Length of time in milliseconds before a request is automatically
  /// terminated.
  ///
  /// When the time has passed, a [TimeoutEvent] is dispatched.
  ///
  /// If [timeout] is set to 0, then the request will not time out.
  ///
  /// ## Other resources
  ///
  /// * [XMLHttpRequest.timeout](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest#xmlhttprequest-timeout)
  ///   from MDN.
  /// * [The timeout attribute](http://www.w3.org/TR/XMLHttpRequest/#the-timeout-attribute)
  ///   from W3C.
  int timeout = 0;

  /// True if cross-site requests should use credentials such as cookies
  /// or authorization headers; false otherwise.
  ///
  /// This value is ignored for same-site requests.
  bool withCredentials = false;

  /// General constructor for any type of request (GET, POST, etc).
  ///
  /// This call is used in conjunction with [open]:
  ///
  ///     var request = new HttpRequest();
  ///     request.open('GET', 'http://dartlang.org');
  ///     request.onLoad.listen((event) => print(
  ///         'Request complete ${event.target.reponseText}'));
  ///     request.send();
  ///
  /// is the (more verbose) equivalent of
  ///
  ///     HttpRequest.getString('http://dartlang.org').then(
  ///         (result) => print('Request complete: $result'));
  factory HttpRequest() = HttpRequest._;

  HttpRequest._() : super._();

  /// Stream of `readystatechange` events handled by this [HttpRequest].
  /// Event listeners to be notified every time the [HttpRequest]
  /// object's `readyState` changes values.
  Stream<Event> get onReadyStateChange => _readyStateStreamController.stream;

  /// Indicator of the current state of the request:
  ///
  /// <table>
  ///   <tr>
  ///     <td>Value</td>
  ///     <td>State</td>
  ///     <td>Meaning</td>
  ///   </tr>
  ///   <tr>
  ///     <td>0</td>
  ///     <td>unsent</td>
  ///     <td><code>open()</code> has not yet been called</td>
  ///   </tr>
  ///   <tr>
  ///     <td>1</td>
  ///     <td>opened</td>
  ///     <td><code>send()</code> has not yet been called</td>
  ///   </tr>
  ///   <tr>
  ///     <td>2</td>
  ///     <td>headers received</td>
  ///     <td><code>sent()</code> has been called; response headers and <code>status</code> are available</td>
  ///   </tr>
  ///   <tr>
  ///     <td>3</td> <td>loading</td> <td><code>responseText</code> holds some data</td>
  ///   </tr>
  ///   <tr>
  ///     <td>4</td> <td>done</td> <td>request is complete</td>
  ///   </tr>
  /// </table>
  int get readyState => _readyState;

  /// The data received as a reponse from the request.
  ///
  /// The data could be in the
  /// form of a [String], [ByteBuffer], [Document], [Blob], or json (also a
  /// [String]). `null` indicates request failure.
  dynamic get response {
    final data = _responseData;
    if (data == null) {
      return null;
    }
    switch (responseType) {
      case 'arraybuffer':
        return data.buffer;
      case 'blob':
        return Blob([data]);
      case 'json':
        return json.decode(utf8.decode(data));
      case 'text':
        return utf8.decode(data);
      default:
        throw UnsupportedError('Response type "$responseType" is unsupported');
    }
  }

  /// Returns all response headers as a key-value map.
  ///
  /// Multiple values for the same header key can be combined into one,
  /// separated by a comma and a space.
  ///
  /// See: http://www.w3.org/TR/XMLHttpRequest/#the-getresponseheader()-method
  Map<String, String>? get responseHeaders => _responseHeaders;

  /// The response in String form or empty String on failure.
  String? get responseText {
    final responseData = _responseData;
    if (responseData == null) {
      return '';
    }
    return utf8.decode(responseData);
  }

  String get responseUrl => throw UnimplementedError();

  /// The request response, or null on failure.
  ///
  /// The response is processed as
  /// `text/xml` stream, unless responseType = 'document' and the request is
  /// synchronous.
  Document get responseXml =>
      DomParser().parseFromString(responseText ?? '', 'text/xml');

  /// The HTTP result code from the request (200, 404, etc).
  /// See also: [HTTP Status Codes](http://en.wikipedia.org/wiki/List_of_HTTP_status_codes)
  int? get status => _status;

  /// The request response string (such as \'200 OK\').
  /// See also: [HTTP Status Codes](http://en.wikipedia.org/wiki/List_of_HTTP_status_codes)
  String? get statusText => _statusText;

  /// [EventTarget] that can hold listeners to track the progress of the request.
  /// The events fired will be members of [HttpRequestUploadEvents].
  @Unstable()
  HttpRequestUpload get upload => throw UnimplementedError();

  /// Stop the current request.
  ///
  /// The request can only be stopped if readyState is `HEADERS_RECEIVED` or
  /// `LOADING`. If this method is not in the process of being sent, the method
  /// has no effect.
  void abort() {
    _requestId++;
    _setReadyState(UNSENT);
  }

  /// Retrieve all the response headers from a request.
  ///
  /// `null` if no headers have been received. For multipart requests,
  /// `getAllResponseHeaders` will return the response headers for the current
  /// part of the request.
  ///
  /// See also [HTTP response
  /// headers](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields#Response_fields)
  /// for a list of common response headers.
  @Unstable()
  String getAllResponseHeaders() => throw UnimplementedError();

  /// Return the response header named `header`, or null if not found.
  ///
  /// See also [HTTP response
  /// headers](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields#Response_fields)
  /// for a list of common response headers.
  @Unstable()
  String? getResponseHeader(String name) {
    return _responseHeaders[name];
  }

  /// Specify the desired `url`, and `method` to use in making the request.
  ///
  /// By default the request is done asyncronously, with no user or password
  /// authentication information. If `async` is false, the request will be sent
  /// synchronously.
  ///
  /// Calling `open` again on a currently active request is equivalent to
  /// calling [abort].
  ///
  /// Note: Most simple HTTP requests can be accomplished using the [getString],
  /// [request], [requestCrossOrigin], or [postFormData] methods. Use of this
  /// `open` method is intended only for more complex HTTP requests where
  /// finer-grained control is needed.
  void open(
    String method,
    String url, {
    bool? async,
    String? user,
    String? password,
  }) {
    // Parse URL
    var parsedUri = Uri.parse(url);

    // Is it a relative URL?
    if (!parsedUri.isAbsolute) {
      parsedUri = Uri.parse(window.location.href).resolveUri(parsedUri);
    }

    if (_readyState != UNSENT) {
      abort();
    }
    _requestMethod = method;
    _requestUrl = parsedUri;
    if (async == false) {
      throw ArgumentError.value(async, 'async');
    }
    _requestHeaders.clear();
    _responseHeaders.clear();
    if (password != null) {
      throw UnimplementedError();
    }
    _setReadyState(OPENED);
  }

  /// Specify a particular MIME type (such as `text/xml`) desired for the
  /// response.
  ///
  /// This value must be set before the request has been sent. See also the list
  /// of [IANA Official MIME types](https://www.iana.org/assignments/media-types/media-types.xhtml).
  void overrideMimeType(String mime) {
    _requestHeaders['Accept'] = mime;
  }

  /// Send the request with any given `data`.
  ///
  /// Note: Most simple HTTP requests can be accomplished using the [getString],
  /// [request], [requestCrossOrigin], or [postFormData] methods. Use of this
  /// `send` method is intended only for more complex HTTP requests where
  /// finer-grained control is needed.
  ///
  /// ## Other resources
  ///
  /// * [XMLHttpRequest.send](https://developer.mozilla.org/en-US/docs/DOM/XMLHttpRequest#send%28%29)
  ///   from MDN.
  void send([body_OR_data]) {
    // Read request body
    Uint8List? data;
    if (body_OR_data != null) {
      if (body_OR_data is String) {
        data = Uint8List.fromList(utf8.encode(body_OR_data));
      } else if (body_OR_data is Uint8List) {
        data = body_OR_data;
      } else {
        throw ArgumentError.value(body_OR_data);
      }
    }

    // Get internal request ID
    _requestId++;
    final requestId = _requestId;

    // Reset response fields
    _status = 0;
    _statusText = '';
    _responseHeaders.clear();
    _responseData = null;

    // Send
    _send(requestId, data);
  }

  /// Sets the value of an HTTP request header.
  ///
  /// This method should be called after the request is opened, but before
  /// the request is sent.
  ///
  /// Multiple calls with the same header will combine all their values into a
  /// single header.
  ///
  /// ## Other resources
  ///
  /// * [XMLHttpRequest.setRequestHeader](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest#setRequestHeader())
  ///   from MDN.
  /// * [The setRequestHeader()
  ///   method](http://www.w3.org/TR/XMLHttpRequest/#the-setrequestheader()-method)
  ///   from W3C.
  void setRequestHeader(String name, String value) {
    _requestHeaders[name] = value;
  }

  Future<void> _send(int requestId, Uint8List? data) async {
    // Was this request aborted while we waited?
    if (_requestId != requestId) {
      return;
    }

    final httpClient =
        window.internalWindowController.onChooseHttpClient(_requestUrl!);
    try {
      // Wait for request
      final httpRequest =
          await httpClient.openUrl(_requestMethod!, _requestUrl!);

      // Was this request aborted while we waited?
      if (_requestId != requestId) {
        return;
      }

      // Set request headers
      _requestHeaders.forEach((name, value) {
        httpRequest.headers.set(name, value);
      });
      httpRequest.headers.set('X-Requested-With', 'XMLHttpRequest');
      final origin = window.location.origin;
      if (origin != null) {
        httpRequest.headers.set('Origin', origin);
      }

      if (data != null) {
        httpRequest.add(data);
      }

      // Wait for response headers
      final httpResponse = await httpRequest.close();

      // Was this request aborted while we waited?
      if (_requestId != requestId) {
        return;
      }

      // Set response status
      _status = httpResponse.statusCode;
      _statusText = httpResponse.reasonPhrase;

      // Set response headers
      httpResponse.headers.forEach((name, values) {
        if (values.isNotEmpty) {
          _responseHeaders[name] = values.first;
        }
      });
      _setReadyState(HEADERS_RECEIVED);

      // Wait for response data
      final buffer = Uint8Buffer();
      await for (var chunk in httpResponse) {
        // Was this request aborted while we waited?
        if (_requestId != requestId) {
          return;
        }
        buffer.addAll(chunk);
      }

      // Was this request aborted while we waited?
      if (_requestId != requestId) {
        return;
      }

      // Set response data
      _responseData = Uint8List.fromList(buffer);
    } catch (error) {
      dispatchEvent(ProgressEvent('error'));
    } finally {
      if (_requestId == requestId) {
        _setReadyState(DONE);
      }
      dispatchEvent(ProgressEvent('loadend'));
    }
  }

  void _setReadyState(int readyState) {
    _readyState = readyState;
    _readyStateStreamController.add(Event.internal('readystatechange'));
  }

  /// Creates a GET request for the specified [url].
  ///
  /// This is similar to [request] but specialized for HTTP GET requests which
  /// return text content.
  ///
  /// To add query parameters, append them to the [url] following a `?`,
  /// joining each key to its value with `=` and separating key-value pairs with
  /// `&`.
  ///
  ///     var name = Uri.encodeQueryComponent('John');
  ///     var id = Uri.encodeQueryComponent('42');
  ///     HttpRequest.getString('users.json?name=$name&id=$id')
  ///       .then((String resp) {
  ///         // Do something with the response.
  ///     });
  ///
  /// See also:
  ///
  /// * [request]
  static Future<String> getString(
    String url, {
    bool withCredentials = false,
    void Function(ProgressEvent e)? onProgress,
  }) {
    return request(
      url,
      withCredentials: withCredentials,
      onProgress: onProgress,
    ).then((HttpRequest xhr) => xhr.responseText ?? '');
  }

  /// Makes a server POST request with the specified data encoded as form data.
  ///
  /// This is roughly the POST equivalent of [getString]. This method is similar
  /// to sending a [FormData] object with broader browser support but limited to
  /// String values.
  ///
  /// If [data] is supplied, the key/value pairs are URI encoded with
  /// [Uri.encodeQueryComponent] and converted into an HTTP query string.
  ///
  /// Unless otherwise specified, this method appends the following header:
  ///
  ///     Content-Type: application/x-www-form-urlencoded; charset=UTF-8
  ///
  /// Here's an example of using this method:
  ///
  ///     var data = { 'firstName' : 'John', 'lastName' : 'Doe' };
  ///     HttpRequest.postFormData('/send', data).then((HttpRequest resp) {
  ///       // Do something with the response.
  ///     });
  ///
  /// See also:
  ///
  /// * [request]
  static Future<HttpRequest> postFormData(
    String url,
    Map<String, String> data, {
    bool? withCredentials,
    String? responseType,
    Map<String, String>? requestHeaders,
    void Function(ProgressEvent e)? onProgress,
  }) {
    var parts = [];
    data.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');

    requestHeaders ??= <String, String>{};
    requestHeaders.putIfAbsent('Content-Type',
        () => 'application/x-www-form-urlencoded; charset=UTF-8');

    return request(
      url,
      method: 'POST',
      withCredentials: withCredentials,
      responseType: responseType,
      requestHeaders: requestHeaders,
      sendData: formData,
      onProgress: onProgress,
    );
  }

  /// Creates and sends a URL request for the specified [url].
  ///
  /// By default `request` will perform an HTTP GET request, but a different
  /// method (`POST`, `PUT`, `DELETE`, etc) can be used by specifying the
  /// [method] parameter. (See also [HttpRequest.postFormData] for `POST`
  /// requests only.
  ///
  /// The Future is completed when the response is available.
  ///
  /// If specified, `sendData` will send data in the form of a [ByteBuffer],
  /// [Blob], [Document], [String], or [FormData] along with the HttpRequest.
  ///
  /// If specified, [responseType] sets the desired response format for the
  /// request. By default it is [String], but can also be 'arraybuffer', 'blob',
  /// 'document', 'json', or 'text'. See also [HttpRequest.responseType]
  /// for more information.
  ///
  /// The [withCredentials] parameter specified that credentials such as a cookie
  /// (already) set in the header or
  /// [authorization headers](http://tools.ietf.org/html/rfc1945#section-10.2)
  /// should be specified for the request. Details to keep in mind when using
  /// credentials:
  ///
  /// * Using credentials is only useful for cross-origin requests.
  /// * The `Access-Control-Allow-Origin` header of `url` cannot contain a wildcard (*).
  /// * The `Access-Control-Allow-Credentials` header of `url` must be set to true.
  /// * If `Access-Control-Expose-Headers` has not been set to true, only a subset of all the response headers will be returned when calling [getAllRequestHeaders].
  ///
  /// The following is equivalent to the [getString] sample above:
  ///
  ///     var name = Uri.encodeQueryComponent('John');
  ///     var id = Uri.encodeQueryComponent('42');
  ///     HttpRequest.request('users.json?name=$name&id=$id')
  ///       .then((HttpRequest resp) {
  ///         // Do something with the response.
  ///     });
  ///
  /// Here's an example of submitting an entire form with [FormData].
  ///
  ///     var myForm = querySelector('form#myForm');
  ///     var data = new FormData(myForm);
  ///     HttpRequest.request('/submit', method: 'POST', sendData: data)
  ///       .then((HttpRequest resp) {
  ///         // Do something with the response.
  ///     });
  ///
  /// Note that requests for file:// URIs are only supported by Chrome extensions
  /// with appropriate permissions in their manifest. Requests to file:// URIs
  /// will also never fail- the Future will always complete successfully, even
  /// when the file cannot be found.
  ///
  /// See also: [authorization headers](http://en.wikipedia.org/wiki/Basic_access_authentication).
  static Future<HttpRequest> request(
    String url, {
    String? method,
    bool? withCredentials,
    String? responseType,
    String? mimeType,
    Map<String, String>? requestHeaders,
    sendData,
    void Function(ProgressEvent e)? onProgress,
  }) {
    var completer = Completer<HttpRequest>();

    var xhr = HttpRequest();
    method ??= 'GET';
    xhr.open(method, url, async: true);

    if (withCredentials != null) {
      xhr.withCredentials = withCredentials;
    }

    if (responseType != null) {
      xhr.responseType = responseType;
    }

    if (mimeType != null) {
      xhr.overrideMimeType(mimeType);
    }

    if (requestHeaders != null) {
      requestHeaders.forEach((header, value) {
        xhr.setRequestHeader(header, value);
      });
    }

    if (onProgress != null) {
      xhr.onProgress.listen(onProgress);
    }

    xhr.onLoad.listen((e) {
      var accepted = xhr.status! >= 200 && xhr.status! < 300;
      var fileUri = xhr.status == 0; // file:// URIs have status of 0.
      var notModified = xhr.status == 304;
      // Redirect status is specified up to 307, but others have been used in
      // practice. Notably Google Drive uses 308 Resume Incomplete for
      // resumable uploads, and it's also been used as a redirect. The
      // redirect case will be handled by the browser before it gets to us,
      // so if we see it we should pass it through to the user.
      var unknownRedirect = xhr.status! > 307 && xhr.status! < 400;

      if (accepted || fileUri || notModified || unknownRedirect) {
        completer.complete(xhr);
      } else {
        completer.completeError(e);
      }
    });

    xhr.onError.listen(completer.completeError);

    if (sendData != null) {
      xhr.send(sendData);
    } else {
      xhr.send();
    }

    return completer.future;
  }

  /// Makes a cross-origin request to the specified URL.
  ///
  /// This API provides a subset of [request] which works on IE9. If IE9
  /// cross-origin support is not required then [request] should be used instead.
  static Future<String> requestCrossOrigin(
    String url, {
    String? method,
    String? sendData,
  }) async {
    final xhr = await request(url, method: method, sendData: sendData);
    return xhr.response as String;
  }
}

class HttpRequestEventTarget extends EventTarget implements HttpRequestUpload {
  /// Static factory designed to expose `abort` events to event
  /// handlers that are not necessarily instances of [HttpRequestEventTarget].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ProgressEvent> abortEvent =
      EventStreamProvider<ProgressEvent>('abort');

  /// Static factory designed to expose `error` events to event
  /// handlers that are not necessarily instances of [HttpRequestEventTarget].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ProgressEvent> errorEvent =
      EventStreamProvider<ProgressEvent>('error');

  /// Static factory designed to expose `load` events to event
  /// handlers that are not necessarily instances of [HttpRequestEventTarget].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ProgressEvent> loadEvent =
      EventStreamProvider<ProgressEvent>('load');

  /// Static factory designed to expose `loadend` events to event
  /// handlers that are not necessarily instances of [HttpRequestEventTarget].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ProgressEvent> loadEndEvent =
      EventStreamProvider<ProgressEvent>('loadend');

  /// Static factory designed to expose `loadstart` events to event
  /// handlers that are not necessarily instances of [HttpRequestEventTarget].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ProgressEvent> loadStartEvent =
      EventStreamProvider<ProgressEvent>('loadstart');

  /// Static factory designed to expose `progress` events to event
  /// handlers that are not necessarily instances of [HttpRequestEventTarget].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ProgressEvent> progressEvent =
      EventStreamProvider<ProgressEvent>('progress');

  /// Static factory designed to expose `timeout` events to event
  /// handlers that are not necessarily instances of [HttpRequestEventTarget].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ProgressEvent> timeoutEvent =
      EventStreamProvider<ProgressEvent>('timeout');

  HttpRequestEventTarget._() : super.internal();

  /// Stream of `abort` events handled by this [HttpRequestEventTarget].
  @override
  Stream<ProgressEvent> get onAbort => abortEvent.forTarget(this);

  /// Stream of `error` events handled by this [HttpRequestEventTarget].
  @override
  Stream<ProgressEvent> get onError => errorEvent.forTarget(this);

  /// Stream of `load` events handled by this [HttpRequestEventTarget].
  @override
  Stream<ProgressEvent> get onLoad => loadEvent.forTarget(this);

  /// Stream of `loadend` events handled by this [HttpRequestEventTarget].
  @override
  Stream<ProgressEvent> get onLoadEnd => loadEndEvent.forTarget(this);

  /// Stream of `loadstart` events handled by this [HttpRequestEventTarget].
  @override
  Stream<ProgressEvent> get onLoadStart => loadStartEvent.forTarget(this);

  /// Stream of `progress` events handled by this [HttpRequestEventTarget].
  @override
  Stream<ProgressEvent> get onProgress => progressEvent.forTarget(this);

  /// Stream of `timeout` events handled by this [HttpRequestEventTarget].
  @override
  Stream<ProgressEvent> get onTimeout => timeoutEvent.forTarget(this);
}

abstract class HttpRequestUpload {
  HttpRequestUpload._();

  Stream<ProgressEvent> get onAbort;
  Stream<ProgressEvent> get onError;
  Stream<ProgressEvent> get onLoad;
  Stream<ProgressEvent> get onLoadEnd;
  Stream<ProgressEvent> get onLoadStart;
  Stream<ProgressEvent> get onProgress;
  Stream<ProgressEvent> get onTimeout;
}
