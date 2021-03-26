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

abstract class ButtonInputElement implements InputElementBase {
  factory ButtonInputElement() => InputElement(type: 'button');
}

abstract class CheckboxInputElement implements InputElementBase {
  bool? checked = false;
  bool required = false;

  factory CheckboxInputElement() => InputElement(type: 'checkbox');
}

abstract class DateInputElement implements RangeInputElementBase {
  static bool get supported => true;

  bool? readOnly;
  bool required = false;
  factory DateInputElement() => InputElement(type: 'date');
  DateTime get valueAsDate => throw UnimplementedError();

  set valueAsDate(DateTime value);
}

abstract class EmailInputElement implements TextInputElementBase {
  static bool get supported => true;

  @override
  String autocomplete = '';

  @override
  bool autofocus = false;

  @override
  int? maxLength;

  bool? multiple = false;

  @override
  String pattern = '';

  @override
  String placeholder = '';

  @override
  bool? readOnly;

  @override
  bool required = false;

  @override
  int? size;

  factory EmailInputElement() => InputElement(type: 'email');

  Element? get list;
}

abstract class FileUploadInputElement implements InputElementBase {
  String? accept;

  bool? multiple = false;

  bool required = true;

  List<File>? files = [];

  factory FileUploadInputElement() => InputElement(type: 'file');
}

abstract class HiddenInputElement implements InputElementBase {
  factory HiddenInputElement() => InputElement(type: 'hidden');
}

abstract class ImageButtonInputElement implements InputElementBase {
  String? alt;
  int? height;
  String? src;
  int? width;

  String? formAction = '';

  String formEnctype = '';

  String formMethod = '';

  bool formNoValidate = false;

  String? formTarget = '';

  factory ImageButtonInputElement() => InputElement(type: 'image');
}

abstract class InputElementBase implements Element {
  bool autofocus = false;

  bool? disabled;

  bool? incremental;

  bool? indeterminate;

  String? name = '';

  String? value;

  InputElementBase._();

  List<Node>? get labels;

  String? get validationMessage;

  ValidityState? get validity;

  bool? get willValidate;

  bool checkValidity();

  void setCustomValidity(String error);
}

abstract class LocalDateTimeInputElement implements RangeInputElementBase {
  static bool get supported => true;

  bool? readOnly;
  bool required = false;

  factory LocalDateTimeInputElement() => InputElement(type: 'datetime-local');
}

abstract class MonthInputElement implements RangeInputElementBase {
  static bool get supported => true;

  bool? readOnly;
  bool required = false;
  factory MonthInputElement() => InputElement(type: 'month');
  DateTime get valueAsDate;

  set valueAsDate(DateTime value);
}

abstract class NumberInputElement implements RangeInputElementBase {
  static bool get supported => true;

  String placeholder = '';
  bool? readOnly;
  bool required = false;

  factory NumberInputElement() => InputElement(type: 'number');

  @override
  num? get valueAsNumber => throw UnimplementedError();
}

abstract class PasswordInputElement implements TextInputElementBase {
  factory PasswordInputElement() => InputElement(type: 'password');
}

abstract class RadioButtonInputElement implements InputElementBase {
  bool? checked = false;
  bool required = false;

  factory RadioButtonInputElement() => InputElement(type: 'radio');
}

abstract class RangeInputElement implements RangeInputElementBase {
  static bool get supported => true;

  factory RangeInputElement() => InputElement(type: 'range');
}

/// Base interface for all input element types which involve ranges.
abstract class RangeInputElementBase implements InputElementBase {
  String? max;

  String? min;

  String? step;

  num? valueAsNumber;

  Element? get list;

  void stepDown([int n]);

  void stepUp([int n]);
}

abstract class ResetButtonInputElement implements InputElementBase {
  factory ResetButtonInputElement() => InputElement(type: 'reset');
}

abstract class SearchInputElement implements TextInputElementBase {
  static bool get supported => true;

  factory SearchInputElement() => InputElement(type: 'search');
}

abstract class SubmitButtonInputElement implements InputElementBase {
  String? formAction = '';

  String formEnctype = '';

  String formMethod = '';

  bool formNoValidate = false;

  String? formTarget = '';

  factory SubmitButtonInputElement() => InputElement(type: 'submit');
}

abstract class TelephoneInputElement implements TextInputElementBase {
  static bool get supported => true;

  factory TelephoneInputElement() => InputElement(type: 'telephone');
}

abstract class TextInputElement implements TextInputElementBase {
  String? dirName;

  factory TextInputElement() => InputElement(type: 'text');

  Element? get list;
}

abstract class TextInputElementBase implements InputElementBase {
  String autocomplete = '';

  int? maxLength;

  String pattern = '';

  String placeholder = '';

  bool? readOnly;

  bool required = false;

  int? size;

  String? selectionDirection;

  int? selectionEnd;

  int? selectionStart;

  void select();

  void setSelectionRange(int start, int end, [String? direction]);
}

abstract class TimeInputElement implements RangeInputElementBase {
  static bool get supported => true;

  bool? readOnly;
  bool required = false;

  factory TimeInputElement() => InputElement(type: 'time');
}

abstract class UrlInputElement implements TextInputElementBase {
  static bool get supported => true;

  factory UrlInputElement() => InputElement(type: 'url');
}

abstract class WeekInputElement implements RangeInputElementBase {
  static bool get supported => true;

  bool? readOnly;
  bool required = false;
  factory WeekInputElement() => InputElement(type: 'week');

  DateTime? get valueAsDate => throw UnimplementedError();
}
