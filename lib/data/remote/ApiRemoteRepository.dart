import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = 'https://www.googleapis.com/discovery/v1';

class ApiRemoteRepository {
  static Future getApis() {
    var url = baseUrl + '/apis';
    return http.get(url);
  }
}