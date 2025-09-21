import "dart:convert";

import "package:dio/dio.dart";
import "package:flutter/foundation.dart";
import "package:injectable/injectable.dart";
import "package:ody_flutter/data/db/service/auth_token_service.dart";
import "package:ody_flutter/data/network/base/base_exception.dart";
import "package:ody_flutter/domain/model/auth_token.dart";

@injectable
class BaseService {
  BaseService(this.authTokenService, this._dio);

  final AuthTokenService authTokenService;
  final Dio _dio;

  Future<AuthToken?> _getStoredToken() => authTokenService.getToken();

  Future<dynamic> postWithResponse({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final AuthToken? token = await _getStoredToken();
      _dio.options.headers = headers ??
          (token != null
              ? {"Authorization": "Bearer access-token=${token.accessToken}"}
              : {});

      final response = await _dio.post(
        path,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<bool> postWithoutResponse({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final AuthToken? token = await _getStoredToken();
      _dio.options.headers = headers ??
          (token != null
              ? {"Authorization": "Bearer access-token=${token.accessToken}"}
              : {});

      final response = await _dio.post(
        path,
        data: data,
      );
      final statusCode = response.statusCode ?? 500;
      return statusCode >= 200 && statusCode < 300;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> getWithResponse({
    String? url,
    String? path,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final AuthToken? token = await _getStoredToken();
      _dio.options.headers = headers ??
          (token != null
              ? {"Authorization": "Bearer access-token=${token.accessToken}"}
              : {});

      final response = await _dio.getUri(
        Uri.parse(url ?? _dio.options.baseUrl + (path ?? "")),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> getWithoutResponse({
    String? url,
    String? path,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final AuthToken? token = await _getStoredToken();
      _dio.options.headers = headers ??
          (token != null
              ? {"Authorization": "Bearer access-token=${token.accessToken}"}
              : {});

      final response = await _dio.getUri(
        Uri.parse(url ?? _dio.options.baseUrl + (path ?? "")),
      );
      final statusCode = response.statusCode ?? 500;
      return statusCode >= 200 && statusCode < 300;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> deleteWithResponse({
    required String path,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final AuthToken? token = await _getStoredToken();
      _dio.options.headers = headers ??
          (token != null
              ? {"Authorization": "Bearer access-token=${token.accessToken}"}
              : {});

      final response = await _dio.delete(
        path,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        throw BaseException.clientError();
      case 401:
        throw BaseException.unauthorizedUser();
      case 404:
        throw BaseException.invalidData();
      case 500:
        throw BaseException.serverError();
      default:
        throw BaseException.unexpectedError(
          message: "${e.message}",
        );
    }
  }
}
