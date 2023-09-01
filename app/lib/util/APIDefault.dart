import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/src/response.dart';

class APIDefault {

  static APIDefault instance = APIDefault();

  // Settings
  final _gateway_stage = "/prod";
  final _endpoint_base = "gq3ykajn8g";
  final _amazon = ".execute-api.us-east-1.amazonaws.com";

  APIDefault();

  String getFullPath(String path) {
    if(path.startsWith("https://")) return path;
    return "https://$_endpoint_base$_amazon$_gateway_stage$path";
  }

  Future<Response> get(String path, Map<String, dynamic> params, [retry = true, String? customApp]) {
    var paramsString = "";
    params.forEach((key, value) => {
      paramsString += (paramsString.isEmpty ? "?" : "&")+key+"="+value.toString()
    });
    final fullPath = getFullPath(path)+paramsString;
    print("[GET] $fullPath");
    return http.get(Uri.parse(fullPath), headers: {'Authorization': "aaa", 'Content-Type': 'application/json'})
        .catchError((error) {
      throw error;
    });
  }

}