part of driver_test;

void _testContentTypeSniffer() {
  group("ContentTypeSniffer", () {
    const sniffer = ContentTypeSniffer();
    const html = "text/html";
    const xml = "text/xml";

    test("Comments and whitespace are skipped", () {
      expect(sniffer.sniffMime('<!----><xml></xml>'), xml);
      expect(sniffer.sniffMime('<!-- --><xml></xml>'), xml);
      expect(sniffer.sniffMime(' <!----> <xml></xml>'), xml);
      expect(sniffer.sniffMime(' <!-- --> <xml></xml>'), xml);
      expect(sniffer.sniffMime('\n<!--\n-->\n<xml></xml>'), xml);
    });
    test("Prefix '<!DOCTYPE html'", () {
      expect(sniffer.sniffMime('<!DOCTYPE html>'), html);
      expect(sniffer.sniffMime('<!DOCTYPE html >'), html);
    });
    test("Prefix '<html'", () {
      expect(sniffer.sniffMime('<html>abc'), html);
      expect(sniffer.sniffMime('<html lang="en">'), html);
    });
    test("Prefix '<xml'", () {
      expect(sniffer.sniffMime('<xml>abc'), xml);
      expect(sniffer.sniffMime('<xml version="1.0">abc'), xml);
    });
  });
}
