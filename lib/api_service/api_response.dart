class ApiResponse {
  int statusCode;
  Map<String, String> headers;
  dynamic body;

  ApiResponse({required this.statusCode, required this.headers, this.body});
}


