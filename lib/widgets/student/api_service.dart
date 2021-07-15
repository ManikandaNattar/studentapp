import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:student_app/widgets/student/student_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://dummy.restapiexample.com/api/v1')
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
      contentType: 'application/json',
      headers: {
        'Accept':'application/json'
      }
    );

    return _ApiService(dio, baseUrl: baseUrl);
  }

  @POST('/create')
  Future<StudentResponse> studentCreate(@Body() Map<String, dynamic> body);
}
