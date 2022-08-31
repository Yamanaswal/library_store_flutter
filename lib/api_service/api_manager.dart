import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_store/library_store.dart';

import 'api_response.dart';
import 'api_services.dart';

const _tag = "ApiManager";

class ApiManager {

  ApiService apiService = ApiService(baseUrl: "");

  // Singleton Class Object
  static final ApiManager _singleton = ApiManager._internal();

  factory ApiManager() {
    return _singleton;
  }

  ApiManager._internal();

  String _baseUrl = "";

  set baseUrl(String value) {
    _baseUrl = value;
    apiService = ApiService(baseUrl: _baseUrl);
  }

  static const defaultHeaders = <String, String>{
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<ApiResponse> getRequestApi(
      {required String endPoint,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      var response = await apiService.request(
          requestType: RequestType.get,
          headers: headers ?? defaultHeaders,
          endPoint: endPoint,
          queryParameters: queryParameters);

      Log.e("$_tag Request :->  ", response.request);
      Log.e("$_tag Response : Status Code :->  ", response.statusCode);
      Log.e("$_tag Response : Headers:->  ", response.headers);
      Log.e("$_tag Response : Body ->  ", response.body);

      return ApiResponse(
        statusCode: response.statusCode,
        headers: response.headers,
        body: json.decode(response.body),
      );
    } catch (ex) {
      Log.e(_tag, "----------- getRequestApi Exception -------- ");
      Log.e(_tag, ex);
    }
    return ApiResponse(statusCode: 0, headers: {});
  }

  Future<ApiResponse> postRequestApi(
      {required String endPoint,
      Map<String, String>? headers,
      Object? body}) async {
    try {
      var response = await apiService.request(
        requestType: RequestType.post,
        endPoint: endPoint,
        headers: headers ?? defaultHeaders,
        body: jsonEncode(body),
      );

      Log.e("$_tag Request :->  ", response.request);
      Log.e("$_tag Response : Status Code :->  ", response.statusCode);
      Log.e("$_tag Response : Headers:->  ", response.headers);
      Log.e("$_tag Response : Body ->  ", response.body);

      return ApiResponse(
        statusCode: response.statusCode,
        headers: response.headers,
        body: json.decode(response.body),
      );
    } catch (ex) {
      Log.e(_tag, "----------- postRequestApi Exception -------- ");
      Log.e(_tag, ex);
    }

    return ApiResponse(statusCode: 0, headers: {});
  }

  Future<ApiResponse> multipartRequestApi(
      {required String endPoint,
      Map<String, String>? headers,
      Map<String, String>? fields,
      List<MultipartFile>? files}) async {
    try {
      var response = await apiService.request(
          requestType: RequestType.multipart,
          endPoint: endPoint,
          headers: headers ?? defaultHeaders,
          fields: fields,
          files: files);

      Log.e("$_tag Request :->  ", response.request);
      Log.e("$_tag Response : Status Code :->  ", response.statusCode);
      Log.e("$_tag Response : Headers:->  ", response.headers);
      Log.e("$_tag Response : Body ->  ", response.body);

      return ApiResponse(
        statusCode: response.statusCode,
        headers: response.headers,
        body: json.decode(response.body),
      );
    } catch (ex) {
      Log.e(_tag, "----------- postRequestApi Exception -------- ");
      Log.e(_tag, ex);
    }

    return ApiResponse(statusCode: 0, headers: {});
  }
}

