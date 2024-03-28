import 'package:k_eventy/core/resources/data_state.dart';
import 'package:k_eventy/features/users/data/models/user.dart';
import 'package:k_eventy/features/users/domain/entities/user.dart';
import 'package:k_eventy/features/users/data/request/login_request.dart';

abstract class UserRepository {
  Future<DataState<void>> createEvent(UserModel user);
  Future<DataState<UserEntity>> loginEvent(LoginRequest request);
}