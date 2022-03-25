import 'package:dio/dio.dart';

class HttpRequest {
  static late Dio dio;
  late BaseOptions options;
  HttpRequest([BaseOptions? baseOptions]) {
    baseOptions ??= BaseOptions(
      baseUrl: "",
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

    print("======");
  }

  Future get(String path, String s,
      {queryParameter, Options? options, CancelToken? cancelToken}) async {
    return await dio.get(path,
        queryParameters: queryParameter,
        options: options,
        cancelToken: cancelToken);
  }

  void post() {
    print("--------------");
  }
}

HttpRequest httpRequest = HttpRequest();
