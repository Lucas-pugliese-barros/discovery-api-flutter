import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:discovery_api_flutter/utils/TimeTracker.dart';

const baseUrl = 'https://www.googleapis.com/discovery/v1';

class ApiRemoteRepository {

  static Future getApis() {
    var url = baseUrl + '/apis';
    var result = http.get(url);
    return result;
  }

}