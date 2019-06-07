part of main_test;

void _testCloning() {
  test("node.clone(true)", () {
    // Create an element with many children
    final original = DivElement();
    for (var tagName in tagNames) {
      original.append(Element.tag(tagName));
    }
    final originalOuterHtml = original.outerHtml;

    // Clone the element
    final clone = original.clone(true) as Element;
    expect(clone.outerHtml, originalOuterHtml);
    _expectSaneTree(clone);
  });

  test("document.adoptNode", () {
    // Create an element with many children
    final original = DivElement();
    for (var tagName in tagNames) {
      original.append(Element.tag(tagName));
    }
    final originalOuterHtml = original.outerHtml;

    // Create a new document
    final document = DomParser().parseFromString("", "text/html");

    // Adopt children from the original element
    final clone = document.adoptNode(original) as Element;
    expect(clone.outerHtml, originalOuterHtml);
    _expectSaneTree(clone);
  });
}

const tagNames = [
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
