import 'dart:convert';

import 'package:health_app_1/domain/model/response_model.dart';
import 'package:http/http.dart';

class ApiService {
  final Client _client = Client();

  Future<ResponseModel?> get(Uri url, Map<String, String> headers) async {
    try {
      final response = await _client.get(url, headers: headers);
      print(response.body);
      return ResponseModel(statusCode: response.statusCode, body: jsonDecode(response.body));
    } catch (e) {
      return null;
    }
  }

  Future<ResponseModel?> post(Uri url, Map<String, String> headers, String body) async {
    try {
      final response = await _client.post(url, headers: headers, body: body);
      return ResponseModel(statusCode: response.statusCode, body: jsonDecode(response.body));
    } catch (e) {
      return null;
    }
  }

  Future<ResponseModel?> put(Uri url, Map<String, String> headers, String body) async {
    try {
      final response = await _client.put(url, headers: headers, body: body);
      return ResponseModel(statusCode: response.statusCode, body: jsonDecode(response.body));
    } catch (e) {
      return null;
    }
  }
}