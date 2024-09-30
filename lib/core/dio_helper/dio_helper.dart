import 'package:dio/dio.dart';

import '../app_storage/app_storage.dart';

class DioHelper {
  static const _baseUrl = "https://ghinaanalshshama.com/api/";
  static late Dio dioSingleton;
  static String? lang;
  static String? deviceToken;
  static Future<void> init() async {
    dioSingleton = Dio()..options.baseUrl = _baseUrl;
    dioSingleton.options.headers
        .addAll({'Accept-Language': "$lang", 'Accept': "application/json"});

    dioSingleton.options.validateStatus = (v) => v! < 500;
  }

  static Future<Response<dynamic>> post(String path,
      {FormData? formData, Map<String, dynamic>? body}) {
    dioSingleton.options.headers.addAll({
      'Content-Type': "application/json",
      'Accept': "application/json",
      'Accept-Language': "$lang",
      if (AppStorage.isLogged) 'Authorization': 'Bearer ${AppStorage.getToken}',
    });
    final response = dioSingleton.post(path,
        data: formData != null ? formData : FormData.fromMap(body!));
    // dio.options.headers = null;
    return response;
  }

  static Future<Response<dynamic>> get(String path) {
    dioSingleton.options.headers.addAll({
      'Content-Type': "application/json",
      'Accept': "application/json",
      'Accept-Language': "$lang",
      if (AppStorage.isLogged) 'Authorization': 'Bearer ${AppStorage.getToken}'
    });
    final response = dioSingleton.get(path);
    // dio.options.headers = null;a
    return response;
  }
}
