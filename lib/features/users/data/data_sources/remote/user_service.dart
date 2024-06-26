import 'dart:io';

import 'package:dio/dio.dart';
import 'package:k_eventy/core/constants/constants.dart';
import 'package:k_eventy/features/users/data/models/user.dart';
import 'package:k_eventy/features/users/data/request/login_request.dart';
import 'package:retrofit/retrofit.dart';

part 'user_service.g.dart';

@RestApi(baseUrl: APIBaseAndroidURL)
abstract class UserService {
  factory UserService(Dio dio) = _UserService;

  @POST('/api/user/login')
  Future<HttpResponse<UserModel>> login(@Body() LoginRequest request);

  @POST('/api/user/create')
  @MultiPart()
  Future<HttpResponse<void>> register(
      @Part(name: "username") String username,
      @Part(name: "password") String password,
      @Part(name: "name") String name,
      @Part(name: "email") String email,
      @Part(name: "profile_file") File imageFile,
      @Part(name: "token") String token,
    );
}







