
import 'package:http/http.dart';
import 'package:library_store/library_store.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Response> request(
      {required RequestType requestType,
      required String endPoint,
      Object? body,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      Map<String, String>? fields,
      List<MultipartFile>? files}) async {
    switch (requestType) {
      case RequestType.get:
        return getRequest(endPoint, queryParameters, headers);
      case RequestType.post:
        return postRequest(endPoint, body, headers);
      case RequestType.delete:
        return deleteRequest(endPoint, body, headers);
      case RequestType.put:
        return putRequest(endPoint, body, headers);
      case RequestType.patch:
        return patchRequest(endPoint, body, headers);
      case RequestType.multipart:
        return multipartRequest(endPoint, fields, files, headers);
      default:
        Log.e(kTag, "No RequestType Provided.");
    }

    return Response("Failure", 0);
  }

  /// *
  /// GET REQUEST
  /// */
  Future<Response> getRequest(
      String endPoint, Map<String, dynamic>? queryParameters,Map<String, String>? headers) async {
    try {
      final uri = Uri.parse(baseUrl + endPoint);
      if (queryParameters != null) {
        uri.replace(queryParameters: queryParameters);
      }
      var response = await get(Uri.parse(baseUrl + endPoint), headers: headers);
      return response;
    } catch (ex) {
      Log.e(kTag, "--------------- getRequest Exception -------------- ");
      Log.e(kTag, ex);
    }
    return Response("Failure", 0);
  }

  /// *
  /// POST REQUEST
  /// */
  Future<Response> postRequest(String endPoint, Object? body,Map<String, String>? headers) async {
    try {
      var response = await post(Uri.parse(baseUrl + endPoint),
          body: body, headers: headers);
      return response;
    } catch (ex) {
      Log.e(kTag, "--------------- postRequest Exception -------------- ");
      Log.e(kTag, ex);
    }
    return Response("Failure", 0);
  }

  /// *
  /// DELETE REQUEST
  /// */
  Future<Response> deleteRequest(String endPoint, Object? body,Map<String, String>? headers) async {
    try {
      var response = await delete(Uri.parse(baseUrl + endPoint),
          headers: headers, body: body);
      return response;
    } catch (ex) {
      Log.e(kTag, "--------------- deleteRequest Exception -------------- ");
      Log.e(kTag, ex);
    }
    return Response("Failure", 0);
  }

  /// *
  /// PUT REQUEST
  /// */
  Future<Response> putRequest(String endPoint, Object? body,Map<String, String>? headers) async {
    try {
      var response = await put(Uri.parse(baseUrl + endPoint),
          headers: headers, body: body);
      return response;
    } catch (ex) {
      Log.e(kTag, "--------------- putRequest Exception -------------- ");
      Log.e(kTag, ex);
    }
    return Response("Failure", 0);
  }

  /// *
  /// PATCH REQUEST
  /// */
  Future<Response> patchRequest(String endPoint, Object? body, Map<String, String>? headers) async {
    try {
      var response = await patch(Uri.parse(baseUrl + endPoint),
          headers: headers, body: body);
      return response;
    } catch (ex) {
      Log.e(kTag, "--------------- patchRequest Exception -------------- ");
      Log.e(kTag, ex);
    }
    return Response("Failure", 0);
  }

  /// *
  /// MULTIPART REQUEST
  /// */
  Future<Response> multipartRequest(
      String endPoint, Map<String, String>? fields, List<MultipartFile>? files, Map<String, String>? headers) async {
    try {
      MultipartRequest request = MultipartRequest('POST', Uri.parse(baseUrl + endPoint));
      request.headers.addAll(headers ?? {});
      request.fields.addAll(fields ?? {});
      request.files.addAll(files ?? {});

      StreamedResponse response = await request.send();
      return Response.fromStream(response);
    } catch (ex) {
      Log.e(kTag, "--------------- multipartRequest Exception -------------- ");
      Log.e(kTag, ex);
    }
    return Response("Failure", 0);
  }
}

enum RequestType { get, post, delete, put, patch, multipart }

const kTag = "ApiService";
