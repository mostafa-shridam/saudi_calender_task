import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:saudi_calender_task/core/constants/constants.dart';

class DioService {
  final Dio dio = Dio();
  static const String baseUrl = baseURL;
  static String userToken = '';

  static String get apiKey =>
      'base64:4b3jXaPNSx7EKge8J3+OPuRTau5oFl2ZtIyYg4Mi0rM=';

  Future<Map<String, String>> headers({required bool withToken}) async {
    return {
      'Content-Type': 'application/json',
      'x-api-key': apiKey,
      if (withToken) 'Authorization': 'Bearer $userToken',
      'x-app-code': appApisKey,
    };
  }

  Future<Map<String, dynamic>?> get(
    String body, {
    required bool withToken,
  }) async {
    try {
      dio.options.headers = await headers(withToken: withToken);
      final Response<String> response = await dio.get('$baseUrl/$body');

      if (response.statusCode == 200) {
        return json.decode(response.data ?? '');
      } else if (response.statusCode == 401) {
        log('Error In GET Request (URL $body) ${response.statusCode}');
        return null;
      } else {
        log('Error In GET Request'); 
        return null;
      }
    } on DioException catch (e) {
      log('Error In GET Request (URL $body) ${e.type.name} ${e.message}');

      return null;
    } catch (e) {
      log('Error In GET Request (URL $body) $e');
      return null;
    }
  }
}
