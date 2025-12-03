import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../auth/data/models/auth_response_dto.dart';
import '../auth/data/models/register_request_dto.dart';

part 'api_client.g.dart';

@singleton
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST("/api/v1/auth/signup")
  Future<AuthResponseDto> signUp(@Body() RegisterRequestDto request);



}
