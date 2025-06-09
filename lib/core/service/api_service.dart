import 'package:dio/dio.dart';
import 'package:yalla_r7la_new/core/service/url_manager.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio});

  Future<Response> getWithToken({
    required String endPoint,
    required String token,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {"Authorization": 'Bearer $token'};
    dio.interceptors.add(CustomLogInterceptor());
    var response = await dio.get(
      '${UrlManager().baseUrl}$endPoint',
      queryParameters: query,
      options: Options(
        validateStatus: (status) {
          return status! == 200 ||
              status == 201 ||
              status == 204 ||
              status == 400 ||
              status == 500;
        },
      ),
    );

    return response;
  }

  Future<Response> getWithoutToken({
    required String endPoint,
    Map<String, dynamic>? query,
  }) async {
    dio.interceptors.add(CustomLogInterceptor());
    var response = await dio.get(
      '${UrlManager().baseUrl}$endPoint',
      queryParameters: query,
      options: Options(
        validateStatus: (status) {
          return status! == 200 ||
              status == 201 ||
              status == 401 ||
              status == 500;
        },
      ),
    );
    return response;
  }

  Future<Response> postWithToken({
    required String endPoint,
    dynamic body,
    required String token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      "Authorization": 'Bearer $token',
    };
    dio.interceptors.add(CustomLogInterceptor());
    var response = await dio.post(
      '${UrlManager().baseUrl}$endPoint',
      data: body,
      options: Options(
        validateStatus: (status) {
          return status! == 200 ||
              status == 201 ||
              status == 400 ||
              status == 500;
        },
      ),
    );

    return response;
  }

  Future<Response> postWithTokenForm({
    required String endPoint,
    dynamic body,
    required String token,
  }) async {
    dio.options.headers = {
      "accept": "*/*",
      'Content-Type': 'multipart/form-data',
      "Authorization": token,
    };
    dio.interceptors.add(CustomLogInterceptor());
    var response = await dio.post(
      '${UrlManager().baseUrl}$endPoint',
      data: body,
      options: Options(
        validateStatus: (status) {
          return status! == 200 ||
              status == 201 ||
              status == 400 ||
              status == 500;
        },
      ),
    );

    return response;
  }

  Future<Response> postWithToken2({
    required String endPoint,
    dynamic body,
    required String token,
  }) async {
    dio.options.headers = {
      "Authorization": 'Bearer $token',
      'Content-Type': 'application/json',
      'accept': 'text/plain',
    };
    dio.interceptors.add(CustomLogInterceptor());
    var response = await dio.post(
      '${UrlManager().baseUrl}$endPoint',
      data: body,
      options: Options(
        validateStatus: (status) {
          return status! == 200 ||
              status == 201 ||
              status == 400 ||
              status == 500;
        },
      ),
    );

    return response;
  }

  Future<Response> postWithoutToken({
    required String endPoint,
    dynamic body,
  }) async {
    dio.options.headers = {"accept": "*/*", "Content-Type": 'application/json'};
    dio.interceptors.add(CustomLogInterceptor());

    var response = await dio.post(
      '${UrlManager().baseUrl}$endPoint',
      data: body,
      options: Options(
        validateStatus: (status) {
          return status == 200 ||
              status == 201 ||
              status == 202 ||
              status == 400 ||
              status == 409 ||
              status == 500;
        },
      ),
    );
    return response;
  }

  Future<Response> putWithoutToken({
    required String endPoint,
    dynamic body,
  }) async {
    dio.options.headers = {"accept": "*/*", "Content-Type": 'application/json'};
    dio.interceptors.add(CustomLogInterceptor());

    var response = await dio.post(
      '${UrlManager().baseUrl}$endPoint',
      data: body,
      options: Options(
        validateStatus: (status) {
          return status == 200 ||
              status == 201 ||
              status == 202 ||
              status == 400 ||
              status == 500;
        },
      ),
    );
    return response;
  }

  Future<Response> put({
    Map<String, dynamic>? headers,
    required String token,
    required endPoint,
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      "accept": "*/*",
      "Content-Type": 'application/json',
      "Authorization": "Bearer $token",
    };
    dio.interceptors.add(CustomLogInterceptor());
    var response = await dio.put(
      '${UrlManager().baseUrl}$endPoint',
      queryParameters: query,
      options: Options(
        validateStatus: (status) {
          return status == 200 ||
              status == 201 ||
              status == 400 ||
              status == 500;
        },
      ),
      data: data,
    );
    return response;
  }

  Future<Response> delete({
    required String endPoint,
    dynamic body,
    dynamic query,
    required String token,
  }) async {
    dio.options.headers = {"Authorization": "Bearer $token", "accept": "*/*"};
    dio.interceptors.add(CustomLogInterceptor());

    return await dio.delete(
      '${UrlManager().baseUrl}$endPoint',
      data: body,
      queryParameters: query,
      options: Options(
        validateStatus: (status) {
          return status == 200 ||
              status == 201 ||
              status == 202 ||
              status == 400 ||
              status == 500;
        },
      ),
    );
  }

  Future<Response> deleteWithoutToken({
    required String endPoint,
    dynamic body,
    dynamic query,
  }) async {
    dio.options.headers = {
      // "Authorization": "Bearer ${HiveStorage.get(HiveKeys.token)}",
      "accept": "*/*",
    };
    dio.interceptors.add(CustomLogInterceptor());

    return await dio.delete(
      '${UrlManager().baseUrl}$endPoint',
      data: body,
      queryParameters: query,
      options: Options(
        validateStatus: (status) {
          return status == 200 ||
              status == 201 ||
              status == 202 ||
              status == 400 ||
              status == 500;
        },
      ),
    );
  }
}

class CustomLogInterceptor extends LogInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Log request URL and headers
    // ignore: avoid_print
    print('--> ${options.method} ${options.uri}');
    options.headers.forEach((key, value) {
      // ignore: avoid_print
      print('$key: $value');
    });

    // Log request body if it's present
    if (options.data != null) {
      // ignore: avoid_print
      print('Request body: ${options.data}');
    }

    super.onRequest(options, handler);
  }
}
