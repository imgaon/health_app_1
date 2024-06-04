class ResponseModel {
  final int statusCode;
  final Map<String, dynamic> body;

  ResponseModel({required this.statusCode, required this.body});

  factory ResponseModel.fromJson(int statusCode, dynamic body) => ResponseModel(
        statusCode: statusCode,
        body: body,
      );

  @override
  String toString() {
    return 'ResponseModel{statusCode: $statusCode, body: $body}';
  }
}
