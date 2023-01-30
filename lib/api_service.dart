import 'dart:async';
import 'package:dio/dio.dart';
import 'package:hor_pao/config/app_config.dart';
import 'package:hor_pao/model/models.dart';
import 'package:hor_pao/utils/exception.dart';

mixin _ApiServiceEndPointMixin {
  final String _getUserUrl = "users";

  final String _postUserUrl = "users";
}

class ApiServices with _ApiServiceEndPointMixin, _ApiServiceMixin {
  ApiServices();

  @override
  String? get token => "QpwL5tke4Pnpja7X4";

  Future<List<User>> getUsers({
    Map<String, dynamic>? query,
  }) async {
    final resp = await _getMethod(
      _getUserUrl,
      queryParams: query,
    );
    return resp["data"].map<User>((e) => User.fromJson(e)).toList();
  }

  Future<User> addUser({user}) async {
    final resp = await _postMethod(_postUserUrl, data: user.toJson());
    return User.fromJson(resp);
  }
}

/// ApiService Method
mixin _ApiServiceMixin {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));

  /// get token from ApiService class
  String? get token;

  Future<Map<String, dynamic>> _getMethod(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final resp = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        }),
      );
      return resp.data;
    } on DioError catch (e) {
      throw throwApiException(e);
    }
  }

  Future<Map<String, dynamic>> _postMethod(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final resp = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        }),
      );
      return resp.data;
    } on DioError catch (e) {
      throw throwApiException(e);
    }
  }
}
