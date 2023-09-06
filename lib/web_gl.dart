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

/// Cross-platform "dart:web_gl" library.
library universal_html.web_gl;

export 'src/_sdk/web_gl.dart'
    if (dart.library.web_gl) 'src/_sdk/web_gl.dart' // Browser
    if (dart.library.io) 'src/web_gl.dart' // VM
    if (dart.library.js) 'src/web_gl.dart'; // Node.JS
