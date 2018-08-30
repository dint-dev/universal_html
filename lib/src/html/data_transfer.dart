part of universal_html;

abstract class DataTransfer {
  String dropEffect;
  String effectAllowed;

  List<File> get files;

  DataTransferItemList get items;

  List<String> get types;

  void clearData([String format]);

  String getData(String format);

  void setData(String format, String data);

  void setDragImage(Element image, int x, int y);
}

abstract class DataTransferItem {
  String get kind;

  String get type;

  Entry getAsEntry();

  File getAsFile();
}

abstract class DataTransferItemList implements List<DataTransferItem> {}
