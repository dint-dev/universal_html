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
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
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

part of universal_html;

class ButtonInputElement extends InputElementBase {
  factory ButtonInputElement() => ButtonInputElement._(null);

  ButtonInputElement._(Document ownerDocument)
      : super._(ownerDocument, "button");

  @override
  Element _newInstance(Document ownerDocument) =>
      ButtonInputElement._(ownerDocument);
}

class CheckboxInputElement extends InputElementBase {
  factory CheckboxInputElement() => CheckboxInputElement._(null);

  CheckboxInputElement._(Document ownerDocument)
      : super._(ownerDocument, "checkbox");

  bool get checked => _getAttributeBool("checked");

  set checked(bool value) {
    _setAttributeBool("checked", value);
  }

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      CheckboxInputElement._(ownerDocument);
}

class DateInputElement extends InputElementBase {
  factory DateInputElement() => DateInputElement._(null);

  DateInputElement._(Document ownerDocument) : super._(ownerDocument, "date");

  bool get readOnly => _getAttributeBool("readOnly");

  set readOnly(bool value) {
    _setAttributeBool("readOnly", value);
  }

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  DateTime get valueAsDate => DateTime.parse(value);

  @override
  Element _newInstance(Document ownerDocument) =>
      DateInputElement._(ownerDocument);
}

class EmailInputElement extends TextInputElementBase
    with _TextInputElementMixin {
  factory EmailInputElement() => EmailInputElement._(null);

  EmailInputElement._(Document ownerDocument) : super._(ownerDocument, "email");

  @override
  Element _newInstance(Document ownerDocument) =>
      EmailInputElement._(ownerDocument);
}

class FileUploadInputElement extends InputElementBase {
  factory FileUploadInputElement() => FileUploadInputElement._(null);

  FileUploadInputElement._(Document ownerDocument)
      : super._(ownerDocument, "file");

  String get accept => _getAttribute("accept");

  set accept(String value) {
    _setAttribute("accept", value);
  }

  List<File> get files => throw UnimplementedError();

  bool get multiple => _getAttributeBool("multiple");

  set multiple(bool value) {
    _setAttributeBool("multiple", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      FileUploadInputElement._(ownerDocument);
}

class HiddenInputElement extends InputElementBase {
  factory HiddenInputElement() => HiddenInputElement._(null);

  HiddenInputElement._(Document ownerDocument)
      : super._(ownerDocument, "hidden");

  @override
  Element _newInstance(Document ownerDocument) =>
      HiddenInputElement._(ownerDocument);
}

class ImageButtonInputElement extends InputElementBase {
  factory ImageButtonInputElement() => ImageButtonInputElement._(null);

  ImageButtonInputElement._(Document ownerDocument)
      : super._(ownerDocument, "image");

  String get alt => _getAttribute("alt");

  set alt(String value) {
    _setAttribute("alt", value);
  }

  int get height => _getAttributeInt("height");

  set height(int value) {
    _setAttributeInt("height", value);
  }

  String get src => _getAttribute("src");

  set src(String value) {
    _setAttribute("src", value);
  }

  int get width => _getAttributeInt("width");

  set width(int value) {
    _setAttributeInt("width", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      ImageButtonInputElement._(ownerDocument);
}

class InputElementBase extends HtmlElement {
  InputElementBase() : super._(null, "INPUT");

  /// IMPORTANT: Not part 'dart:html'.
  factory InputElementBase.internalFromType(
      Document ownerDocument, String type) {
    type = type.toLowerCase();
    switch (type) {
      case "button":
        return ButtonInputElement._(ownerDocument);
      case "checkbox":
        return CheckboxInputElement._(ownerDocument);
      case "date":
        return DateInputElement._(ownerDocument);
      case "datetime-local":
        return LocalDateTimeInputElement._(ownerDocument);
      case "email":
        return EmailInputElement._(ownerDocument);
      case "hidden":
        return HiddenInputElement._(ownerDocument);
      case "image":
        return ImageButtonInputElement._(ownerDocument);
      case "number":
        return NumberInputElement._(ownerDocument);
      case "password":
        return PasswordInputElement._(ownerDocument);
      case "submit":
        return SubmitButtonInputElement._(ownerDocument);
      case "telephone":
        return TelephoneInputElement._(ownerDocument);
      case "text":
        return TextInputElement._(ownerDocument);
      case "time":
        return TimeInputElement._(ownerDocument);
      case "radio":
        return RadioButtonInputElement._(ownerDocument);
      case "reset":
        return ResetButtonInputElement._(ownerDocument);
      case "url":
        return UrlInputElement._(ownerDocument);
      default:
        return InputElementBase._(ownerDocument, null);
    }
  }

  InputElementBase._(Document ownerDocument, String type)
      : super._(ownerDocument, "input") {
    if (type != null) {
      _setAttribute("type", type);
    }
  }

  bool get autofocus => _getAttributeBool("autofocus");

  set autofocus(bool value) {
    _setAttributeBool("autofocus", value);
  }

  bool get disabled => _getAttributeBool("disabled");

  set disabled(bool value) {
    _setAttributeBool("disabled", value);
  }

  String get name => _getAttribute("name");

  set name(String value) {
    _setAttribute("name", value);
  }

  String get validationMessage => _getAttribute("validationmessage");

  set validationMessage(String value) {
    _setAttribute("validationmessage", value);
  }

  ValidityState get validity => throw UnimplementedError();

  String get value => _getAttribute("value");

  set value(String value) {
    _setAttribute("value", value);
  }

  num get valueAsNumber {
    final value = this.value;
    return value == null ? null : num.parse(value);
  }

  set valueAsNumber(num value) {
    this.value = value?.toString();
  }

  bool checkValidity() => true;

  @override
  Element _newInstance(Document ownerDocument) =>
      InputElementBase._(ownerDocument, null);
}

class LocalDateTimeInputElement extends InputElementBase {
  factory LocalDateTimeInputElement() => LocalDateTimeInputElement._(null);

  LocalDateTimeInputElement._(Document ownerDocument)
      : super._(ownerDocument, "datetime-local");

  bool get readOnly => _getAttributeBool("readOnly");

  set readOnly(bool value) {
    _setAttributeBool("readOnly", value);
  }

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  DateTime get valueAsDate => DateTime.parse(value);

  @override
  Element _newInstance(Document ownerDocument) =>
      LocalDateTimeInputElement._(ownerDocument);
}

class MonthInputElement extends InputElementBase {
  MonthInputElement() : this._(null);
  MonthInputElement._(Document ownerDocument) : super._(ownerDocument, "month");
}

class NumberInputElement extends InputElementBase {
  factory NumberInputElement() => NumberInputElement._(null);

  NumberInputElement._(Document ownerDocument)
      : super._(ownerDocument, "number");

  String get placeholder => _getAttribute("placeholder");

  set placeholder(String value) {
    _setAttribute("placeholder", value);
  }

  bool get readOnly => _getAttributeBool("readOnly");

  set readOnly(bool value) {
    _setAttributeBool("readOnly", value);
  }

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      NumberInputElement._(ownerDocument);
}

class PasswordInputElement extends TextInputElementBase
    with _TextInputElementMixin {
  factory PasswordInputElement() => PasswordInputElement._(null);

  PasswordInputElement._(Document ownerDocument)
      : super._(ownerDocument, "password");

  @override
  Element _newInstance(Document ownerDocument) =>
      PasswordInputElement._(ownerDocument);
}

class RadioButtonInputElement extends InputElementBase {
  factory RadioButtonInputElement() => RadioButtonInputElement._(null);

  RadioButtonInputElement._(Document ownerDocument)
      : super._(ownerDocument, "radio");

  bool get checked => _getAttributeBool("checked");

  set checked(bool value) {
    _setAttributeBool("checked", value);
  }

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      RadioButtonInputElement._(ownerDocument);
}

class RangeInputElement extends InputElementBase {
  RangeInputElement() : this._(null);
  RangeInputElement._(Document ownerDocument) : super._(ownerDocument, "range");
}

class ResetButtonInputElement extends InputElementBase {
  factory ResetButtonInputElement() => ResetButtonInputElement._(null);

  ResetButtonInputElement._(Document ownerDocument)
      : super._(ownerDocument, "reset");

  @override
  Element _newInstance(Document ownerDocument) =>
      ResetButtonInputElement._(ownerDocument);
}

class SearchInputElement extends TextInputElementBase
    with _TextInputElementMixin {
  factory SearchInputElement() => SearchInputElement._(null);

  SearchInputElement._(Document ownerDocument)
      : super._(ownerDocument, "search");

  @override
  Element _newInstance(Document ownerDocument) =>
      SearchInputElement._(ownerDocument);
}

class SubmitButtonInputElement extends InputElementBase {
  factory SubmitButtonInputElement() => SubmitButtonInputElement._(null);

  SubmitButtonInputElement._(Document ownerDocument)
      : super._(ownerDocument, "submit");

  @override
  Element _newInstance(Document ownerDocument) =>
      SubmitButtonInputElement._(ownerDocument);
}

class TelephoneInputElement extends TextInputElementBase
    with _TextInputElementMixin {
  factory TelephoneInputElement() => TelephoneInputElement._(null);

  TelephoneInputElement._(Document ownerDocument)
      : super._(ownerDocument, "telephone");
}

class TextInputElement extends TextInputElementBase
    with _TextInputElementMixin {
  factory TextInputElement() => TextInputElement._(null);

  TextInputElement._(Document ownerDocument) : super._(ownerDocument, "text");

  @override
  Element _newInstance(Document ownerDocument) =>
      TextInputElement._(ownerDocument);
}

abstract class TextInputElementBase extends InputElementBase {
  RegExp _patternRegExp;

  TextInputElementBase() : super();

  TextInputElementBase._(Document ownerDocument, String type)
      : super._(ownerDocument, type);

  int get maxLength => _getAttributeInt("maxlength");

  set maxLength(int value) {
    _setAttributeInt("maxlength", value);
  }

  int get minLength => _getAttributeInt("minlength");

  set minLength(int value) {
    _setAttributeInt("minlength", value);
  }

  String get pattern => _getAttribute("pattern");

  set pattern(String value) {
    _setAttribute("pattern", value);
  }

  String get placeholder => _getAttribute("placeholder");

  set placeholder(String value) {
    _setAttribute("placeholder", value);
  }

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  bool checkValidity();
}

class TimeInputElement extends InputElementBase {
  factory TimeInputElement() => TimeInputElement._(null);

  TimeInputElement._(Document ownerDocument) : super._(ownerDocument, "time");

  bool get readOnly => _getAttributeBool("readOnly");

  set readOnly(bool value) {
    _setAttributeBool("readOnly", value);
  }

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  DateTime get valueAsDate => DateTime.parse(value);

  @override
  Element _newInstance(Document ownerDocument) =>
      TimeInputElement._(ownerDocument);
}

class UrlInputElement extends TextInputElementBase {
  factory UrlInputElement() => UrlInputElement._(null);

  UrlInputElement._(Document ownerDocument) : super._(ownerDocument, "url");

  @override
  Element _newInstance(Document ownerDocument) =>
      UrlInputElement._(ownerDocument);
}

class WeekInputElement extends InputElementBase {
  WeekInputElement() : this._(null);
  WeekInputElement._(Document ownerDocument) : super._(ownerDocument, "week");
}

abstract class _TextInputElementMixin implements InputElementBase {
  RegExp _patternRegExp;

  int get minLength;
  String get pattern;
  bool get required;

  @override
  bool checkValidity() => _checkValidity(value);

  bool _checkValidity(String value) {
    if (value == null) return !required;
    final minLength = this.minLength;
    if (minLength is int && minLength > value.length) {
      return false;
    }
    final maxLength = this.minLength;
    if (maxLength is int && maxLength < value.length) {
      return false;
    }
    final regExp = this._getRegExp();
    if (regExp != null && !regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  RegExp _getRegExp() {
    final pattern = this.pattern;
    if (pattern == null) {
      return null;
    }
    var regExp = this._patternRegExp;
    if (regExp != null && pattern == regExp.pattern) {
      return regExp;
    }
    regExp = RegExp(pattern);
    _patternRegExp = regExp;
    return regExp;
  }
}
