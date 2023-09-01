extension Unwrapper on Map {

  String getString(String key) {
    var value = this[key];
    if(value != null) {
      return value is String ? value : "$value";
    } else {
      return "";
    }
  }
  int getInt(String key) {
    var value = this[key];
    if(value != null) {
      return value is int ? value : value is String ? int.parse(value+"") : 0;
    }
    return 0;
  }
  int getBigInt(String key) {
    final value = this.getString(key);
    try {
      return value != null ? int.parse(value) : 0;
    } catch(error) {
      return 0;
    }
  }
  double getDouble(String key) {
    var value = this[key];
    return value != null && value is double ? value : this.getInt(key).toDouble();
  }
  bool getBool(String key) {
    var value = this[key];
    return value != null && value is bool ? value : false;
  }

}