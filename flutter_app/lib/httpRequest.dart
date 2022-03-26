import 'package:dio/dio.dart';

class HttpRequest {
  static late Dio dio;
  late BaseOptions options;
  HttpRequest([BaseOptions? baseOptions]) {
    baseOptions ??= BaseOptions(
      baseUrl: "http://localhost:3000",
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    options = baseOptions;
    dio = Dio(baseOptions);
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      return handler.next(e); //continue
    }));
  }

  Future get(String path,
      {queryParameter, Options? options, CancelToken? cancelToken}) async {
    return await dio.get(path,
        queryParameters: queryParameter,
        options: options,
        cancelToken: cancelToken);
  }
}

HttpRequest httpRequest = HttpRequest();
