import 'package:dio/dio.dart';
import 'package:k_eventy/core/resources/data_state.dart';
import 'package:k_eventy/core/usecase/usecase.dart';
import 'package:k_eventy/features/users/data/models/user.dart';
import 'package:k_eventy/features/users/domain/entities/user.dart';
import 'package:k_eventy/features/users/domain/repositories/user_repository.dart';

class CreateUserUseCase implements UseCase<DataState<void>, UserModel> {
  final UserRepository _userReposity;
  CreateUserUseCase(this._userReposity);

  @override
  Future<DataState<void>> call({UserModel? params}) {
    if (params != null) {
      return _userReposity.createEvent(params);
    }

    return Future(() => DataFailed(
        DioException(
            requestOptions: RequestOptions(
                data: "user params is null"
            )
        )
    ));
  }
}