import 'package:dio/dio.dart';

import 'end_points.dart';

class ApiManager{
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.BASEURL,
      contentType: 'application/json',
      responseType: ResponseType.json,
      connectTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      headers: {
        "contentType": "application/json",
        "accept": "application/json",
      },
    ),
  );


}