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

/// Creates and controls browser simulators.
library universal_html.driver;

export 'src/driver/content_loading.dart';
export 'src/driver/content_type_sniffer.dart';
export 'src/driver/csp.dart';
export 'src/driver/dom_parser_driver.dart';
export 'src/driver/html_driver.dart';
export 'src/driver/server_side_renderer.dart';
export 'src/driver/user_agent.dart';
export 'src/html_with_internals.dart'
    show BrowserImplementation, BrowserImplementationUtils, RenderData;
