import "dart:convert";

import "package:dio/dio.dart";
import "package:flutter/foundation.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:injectable/injectable.dart";
import "package:ody_flutter/data/db/service/auth_token_service.dart";
import "package:ody_flutter/data/network/base/base_exception.dart";
import "package:ody_flutter/domain/model/auth_token.dart";

@injectable
class BaseService {
  BaseService(this.authTokenService) {
    _setupInterceptors();
  }

  final AuthTokenService authTokenService;

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.get("BASE_DEV_URL"),
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: Headers.jsonContentType,
    ),
  );

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          _printSuccessLog(response);
          handler.next(response);
        },
        onError: (error, handler) {
          _printErrorLog(error);
          handler.next(error);
        },
      ),
    );
  }

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

  void _printSuccessLog(Response response) {
    debugPrint("""
=== [Network Success] ======================================
🟢 Request Info:
  • URL: ${response.requestOptions.uri}
  • Method: ${response.requestOptions.method}
  • Headers: ${_formatJson(response.requestOptions.headers)}
  • Data: ${_formatJson(response.requestOptions.data)}

✅ Response Info:
  • Status Code: ${response.statusCode}
  • Status Message: ${response.statusMessage}
  • Response Data: ${_formatJson(response.data)}
============================================================
""");
  }

  void _printErrorLog(DioException e) {
    debugPrint("""
=== [Network Error] =========================================
🔴 Request Info:
  • URL: ${e.requestOptions.uri}
  • Method: ${e.requestOptions.method}
  • Headers: ${_formatJson(e.requestOptions.headers)}
  • Data: ${_formatJson(e.requestOptions.data)}

❌ Response Error:
  • Status Code: ${e.response?.statusCode}
  • Status Message: ${e.response?.statusMessage}
  • Response Data: ${_formatJson(e.response?.data)}

🗯️ Error Message:
  ${e.message}
============================================================
""");
  }

  String _formatJson(json) {
    const encoder = JsonEncoder.withIndent("  ");
    try {
      return encoder.convert(json);
    } on Exception catch (_) {
      return json.toString();
    }
  }
}
