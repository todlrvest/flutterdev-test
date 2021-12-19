class QuestionDataResponse {
  final bool? success;
  final String? title;
  final String? message;
  final String? data;
  final int? internalResponseCode;

  QuestionDataResponse({
    this.success,
    this.title,
    this.message,
    this.data,
    this.internalResponseCode,
  });

  QuestionDataResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        title = json['title'] as String?,
        message = json['message'] as String?,
        data = json['data'] as String?,
        internalResponseCode = json['internal_response_code'] as int?;

  Map<String, dynamic> toJson() => {
        'success': success,
        'title': title,
        'message': message,
        'data': data,
        'internal_response_code': internalResponseCode
      };
}
