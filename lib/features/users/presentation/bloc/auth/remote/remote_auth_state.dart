
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:k_eventy/features/users/domain/entities/user.dart';

abstract class RemoteAuthState extends Equatable {
  final UserEntity ? user;
  final DioException ? exception;
  const RemoteAuthState({this.user, this.exception});

  @override
  List<Object> get props => [user!, exception!];
}

class RemoteAuthInit extends RemoteAuthState {
  const RemoteAuthInit();
}

class RemoteAuthLoading extends RemoteAuthState {
  const RemoteAuthLoading();
}

class RemoteAuthDone extends RemoteAuthState {
  const RemoteAuthDone();
}

class RemoteAuthError extends RemoteAuthState {
  const RemoteAuthError(DioException exception) : super(exception: exception);
}