import 'dart:io';

import 'package:dio/dio.dart';
import 'package:k_eventy/core/resources/data_state.dart';
import 'package:k_eventy/features/users/data/data_sources/remote/user_service.dart';
import 'package:k_eventy/features/users/data/models/user.dart';
import 'package:k_eventy/features/users/domain/entities/user.dart';
import 'package:k_eventy/features/users/domain/repositories/user_repository.dart';
import 'package:k_eventy/features/users/data/request/login_request.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService _userService;
  UserRepositoryImpl(this._userService);

  @override
  Future<DataState<UserEntity>> loginEvent(LoginRequest request) async {
    try {
      final httpResponse = await _userService.login(request);
      if(httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioExceptionType.badResponse,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioException catch(e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> createEvent(UserModel user) async{
    try {
      final httpResponse = await _userService.register(
          user.username! ,
          user.password!,
          user.name!,
          user.email!,
          user.imageFile!
      );
      if(httpResponse.response.statusCode == HttpStatus.created) {
        return const DataSuccess<void>(null);
      } else {
        return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioExceptionType.badResponse,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioException catch(e) {
      return DataFailed(e);
    }
  }
}