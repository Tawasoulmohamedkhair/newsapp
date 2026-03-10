// import 'dart:convert';

// import 'package:http/http.dart' as http;

// class ApiConfig {
//   static const baseUrl = 'https://newsapi.org/v2';
//   static const String apikey = '409be785b7444f3895660dfcf19217f1';

//   //Endpoint
//   static const String topHeadlines = "top-headlines";
//   static const String everyThing = "everything";

//   Future<dynamic> get(String endpoint) async {
//     var url = Uri.parse('${ApiConfig.baseUrl}/$endpoint');
//     final http.Response respone = await http.get(url);
//     return jsonDecode(respone.body) as Map<String, dynamic>;
//   }
// }

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/core/constant/apiconfig.dart';

class ApiService {
  Future<dynamic> get(String endpoint, {Map<String, String>? params}) async {
    var url = Uri.http(ApiConfig.baseUrl, 'v2/$endpoint', {
      'apiKey': ApiConfig.apikey,
      ...?params,
    });

    try {
      final http.Response response = await http.get(url);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
