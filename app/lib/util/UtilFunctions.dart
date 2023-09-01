import 'dart:convert';
import 'package:http/http.dart';

import 'package:flutter/services.dart';

class UtilFunctions {

  static hideKeyboard() {
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    } catch(error) {}
  }

  static String bodyFromResponse(Response response) {
    return utf8.decode(response.bodyBytes);
  }

}