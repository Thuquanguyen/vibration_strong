
class DataHolder {
  static final DataHolder _singleton = DataHolder._internal();

  factory DataHolder() {
    return _singleton;
  }

  DataHolder._internal();

  dynamic args;
}
