import 'package:json_annotation/json_annotation.dart';

part 'student_response.g.dart';

@JsonSerializable()
class StudentResponse {
  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'message')
  final String? message;

  StudentResponse({
    this.status,
    this.message,
  });

  factory StudentResponse.fromJson(Map<String, dynamic> json) =>
      _$StudentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StudentResponseToJson(this);
}
