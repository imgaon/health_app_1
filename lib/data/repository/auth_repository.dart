import 'dart:convert';

import 'package:health_app_1/data/service/api_service.dart';
import 'package:health_app_1/domain/type/status_type.dart';
import 'package:health_app_1/util/prefs.dart';

class AuthRepository {
  final ApiService apiService;

  AuthRepository({required this.apiService});

  final String _baseUrl = "http://10.114.181.205:8082";

  Future<StatusType> login({required Map<String, String> userData}) async {
    final Uri url = Uri.parse('$_baseUrl/auth/login');
    final Map<String, String> headers = {'Content-Type' : 'application/json'};
    final String body = jsonEncode(userData);

    final response = await apiService.post(url, headers, body);

    if (response == null) return StatusType.error;

    if (response.statusCode == 200) {
      final String token = response.body!['access_token'];
      prefs.prefs.setString('token', token);
      return StatusType.success;
    }

    if (response.statusCode == 401) return StatusType.userNotFount;

    return StatusType.notFound;
  }

  Future<StatusType> register({required Map<String, dynamic> userData}) async {
    final Uri url = Uri.parse('$_baseUrl/auth/register');
    final Map<String, String> headers = {'Content-Type' : 'application/json'};
    final String body = jsonEncode(userData);

    final response = await apiService.post(url, headers, body);

    if (response == null) return StatusType.error;

    if (response.statusCode == 201) return StatusType.success;

    if (response.statusCode == 400) return StatusType.success;
    return StatusType.notFound;
  }


  Future<StatusType> update({required Map<String, dynamic> userData}) async {
    final Uri url = Uri.parse('$_baseUrl/user/update');
    final String token = prefs.prefs.getString('token') ?? '';
    final Map<String ,String> headers = {
      "Authorization" : 'Bearer $token',
      'Content-Type' : 'application/json',
    };
    final String body = jsonEncode(userData);

    final response = await apiService.put(url, headers, body);

    if (response == null) return StatusType.error;

    if (response.statusCode == 200) return StatusType.success;

    return StatusType.notFound;
  }

}