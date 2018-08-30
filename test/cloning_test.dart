import 'package:test/test.dart';
import 'package:universal_html/html.dart';

import 'helpers.dart';

void main() {
  test("Cloning DOM", () {
    final original = new DivElement();
    for (var tagName in tagNames) {
      original.append(new Element.tag(tagName));
    }
    final clone = original.clone(true) as Element;
    expect(clone.outerHtml, equals(original.outerHtml));
    expectSaneTree(clone);
  });

  test("Adopting DOM", () {
    final original = new DivElement();
    for (var tagName in tagNames) {
      original.append(new Element.tag(tagName));
    }
    final document = new DomParser().parseFromString("", "text/html");
    final clone = document.adoptNode(original) as Element;
    expect(clone.outerHtml, equals(original.outerHtml));
    expectSaneTree(clone);
  });
}

const tagNames = const [
  'A',
  'ABBR',
  'ACRONYM',
  'ADDRESS',
  'AREA',
  'ARTICLE',
  'ASIDE',
  'AUDIO',
  'B',
  'BDI',
  'BDO',
  'BIG',
  'BLOCKQUOTE',
  'BR',
  'BUTTON',
  'CANVAS',
  'CAPTION',
  'CENTER',
  'CITE',
  'CODE',
  'COL',
  'COLGROUP',
  'COMMAND',
  'DATA',
  'DATALIST',
  'DD',
  'DEL',
  'DETAILS',
  'DFN',
  'DIR',
  'DIV',
  'DL',
  'DT',
  'EM',
  'FIELDSET',
  'FIGCAPTION',
  'FIGURE',
  'FONT',
  'FOOTER',
  'FORM',
  'H1',
  'H2',
  'H3',
  'H4',
  'H5',
  'H6',
  'HEADER',
  'HGROUP',
  'HR',
  'I',
  'IFRAME',
  'IMG',
  'INPUT',
  'INS',
  'KBD',
  'LABEL',
  'LEGEND',
  'LI',
  'MAP',
  'MARK',
  'MENU',
  'METER',
  'NAV',
  'NOBR',
  'OL',
  'OPTGROUP',
  'OPTION',
  'OUTPUT',
  'P',
  'PRE',
  'PROGRESS',
  'Q',
  'S',
  'SAMP',
  'SECTION',
  'SELECT',
  'SMALL',
  'SOURCE',
  'SPAN',
  'STRIKE',
  'STRONG',
  'SUB',
  'SUMMARY',
  'SUP',
  'TABLE',
  'TBODY',
  'TD',
  'TEXTAREA',
  'TFOOT',
  'TH',
  'THEAD',
  'TIME',
  'TR',
  'TRACK',
  'TT',
  'U',
  'UL',
  'VAR',
  'VIDEO',
  'WBR',
];
