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

/// Cross-platform "dart:svg" library.
library universal_html.svg;

export 'src/_sdk/svg.dart'
    if (dart.library.svg) 'src/_sdk/svg.dart' // Browser
    if (dart.library.io) 'src/svg.dart' // VM
    if (dart.library.js) 'src/svg.dart'; // Node.JS
