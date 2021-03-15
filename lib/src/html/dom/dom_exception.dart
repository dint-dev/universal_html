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

class DomError implements Exception {
  final String? message;
  final String name;

  DomError(this.name, [this.message]);

  @override
  String toString() => '$name: $message';
}

class DomException implements Exception {
  static const String INDEX_SIZE = 'IndexSizeError';
  static const String HIERARCHY_REQUEST = 'HierarchyRequestError';
  static const String WRONG_DOCUMENT = 'WrongDocumentError';
  static const String INVALID_CHARACTER = 'InvalidCharacterError';
  static const String NO_MODIFICATION_ALLOWED = 'NoModificationAllowedError';
  static const String NOT_FOUND = 'NotFoundError';
  static const String NOT_SUPPORTED = 'NotSupportedError';
  static const String INVALID_STATE = 'InvalidStateError';
  static const String SYNTAX = 'SyntaxError';
  static const String INVALID_MODIFICATION = 'InvalidModificationError';
  static const String NAMESPACE = 'NamespaceError';
  static const String INVALID_ACCESS = 'InvalidAccessError';
  static const String TYPE_MISMATCH = 'TypeMismatchError';
  static const String SECURITY = 'SecurityError';
  static const String NETWORK = 'NetworkError';
  static const String ABORT = 'AbortError';
  static const String URL_MISMATCH = 'URLMismatchError';
  static const String QUOTA_EXCEEDED = 'QuotaExceededError';
  static const String TIMEOUT = 'TimeoutError';
  static const String INVALID_NODE_TYPE = 'InvalidNodeTypeError';
  static const String DATA_CLONE = 'DataCloneError';
  static const String ENCODING = 'EncodingError';
  static const String NOT_READABLE = 'NotReadableError';
  static const String UNKNOWN = 'UnknownError';
  static const String CONSTRAINT = 'ConstraintError';
  static const String TRANSACTION_INACTIVE = 'TransactionInactiveError';
  static const String READ_ONLY = 'ReadOnlyError';
  static const String VERSION = 'VersionError';
  static const String OPERATION = 'OperationError';
  static const String NOT_ALLOWED = 'NotAllowedError';
  static const String TYPE_ERROR = 'TypeError';

  final String? message;
  final String name;

  DomException._(this.name, [this.message]);

  factory DomException._failedToExecute(
      String name, String type, String method, String message) {
    return DomException._(
        name, 'Failed to execute "$method" on "$type": $message');
  }

  factory DomException._invalidMethod(String type, String method) {
    return DomException._failedToExecute(
      DomException.INVALID_MODIFICATION,
      type,
      method,
      'This node type does not support this method.',
    );
  }

  factory DomException._mayNotBeInsertedInside(
      String type, String method, Node node, Node parent) {
    return DomException._failedToExecute(
        DomException.HIERARCHY_REQUEST,
        type,
        method,
        'Nodes of type \'#${node._nodeTypeName}\' may not be inserted inside nodes of type \'#${parent._nodeTypeName}\'.');
  }

  @override
  String toString() => '$name: $message';
}
