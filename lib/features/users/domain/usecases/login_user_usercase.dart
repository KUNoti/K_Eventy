import 'package:dio/dio.dart';
import 'package:k_eventy/core/resources/data_state.dart';
import 'package:k_eventy/core/usecase/usecase.dart';
import 'package:k_eventy/features/users/domain/entities/user.dart';
import 'package:k_eventy/features/users/domain/repositories/user_repository.dart';
import 'package:k_eventy/features/users/data/request/login_request.dart';

class LoginUserUseCase implements UseCase<DataState<UserEntity>, LoginRequest> {
  final UserRepository _userRepository;
  LoginUserUseCase(this._userRepository);

  @override
  Future<DataState<UserEntity>> call({LoginRequest? params}) {
    if (params != null) {
      return _userRepository.loginEvent(params);
    }

    return Future(() => DataFailed(
      DioException(
        requestOptions:  RequestOptions(
          data: "login params is null"
        )
      )
    ));
  }

}