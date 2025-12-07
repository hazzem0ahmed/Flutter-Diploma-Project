import 'package:dio/dio.dart';

abstract class ParseErrorLogger {
  void logError<T>(
    Object error,
    StackTrace stackTrace,
    RequestOptions requestOptions,
    Response<dynamic>? response,
  );
}
