import 'package:dio/dio.dart';

Dio dio = Dio(
  BaseOptions(
    baseUrl: "https://yts.mx",
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 40),
    receiveTimeout: const Duration(seconds: 40),
    sendTimeout: const Duration(seconds: 40),
    headers: {
      'Accept': 'application/json',

      'User-Agent': 'Mozilla/5.0',
    },
  ),
);