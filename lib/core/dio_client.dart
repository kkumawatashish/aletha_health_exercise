

import 'package:aletha_health_exercise/core/utils/constants.dart';
import 'package:dio/dio.dart';

class DioClient {

  final dio = Dio(
    BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: Duration(seconds: 60),
      sendTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60)
    )
  );



  Dio get instance => dio;
}