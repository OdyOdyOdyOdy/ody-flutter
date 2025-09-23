import "dart:convert";

import "package:dio/dio.dart";
import "package:flutter/foundation.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:injectable/injectable.dart";

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.get("BASE_DEV_URL"),
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: Headers.jsonContentType,
      ),
    );

    dio.interceptors.add(
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
    return dio;
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
