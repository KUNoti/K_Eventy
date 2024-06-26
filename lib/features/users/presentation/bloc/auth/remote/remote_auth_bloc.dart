
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_eventy/core/firebase/notification/firebase_api.dart';
import 'package:k_eventy/core/resources/data_state.dart';
import 'package:k_eventy/features/users/domain/entities/user.dart';
import 'package:k_eventy/features/users/domain/usecases/create_user_usecase.dart';
import 'package:k_eventy/features/users/domain/usecases/login_user_usercase.dart';
import 'package:k_eventy/features/users/presentation/bloc/auth/remote/remote_auth_event.dart';
import 'package:k_eventy/features/users/presentation/bloc/auth/remote/remote_auth_state.dart';

class RemoteAuthBloc extends Bloc<RemoteAuthEvent, RemoteAuthState> {
  final LoginUserUseCase _loginUserUseCase;
  final CreateUserUseCase _createUserUseCase;
  UserEntity? user;
  final FirebaseApi _firebaseApi;

  RemoteAuthBloc(this._loginUserUseCase, this._createUserUseCase, this._firebaseApi) : super(const RemoteAuthInit()) {
    on <LoginEvents> (onLoginEvents);
    on <RegisterEvent> (onRegisterEvents);
    _firebaseApi.initNotifications();
  }

  void onLoginEvents(LoginEvents event, Emitter<RemoteAuthState> emit) async {
    emit(const RemoteAuthLoading());
    try {
      final dataState = await _loginUserUseCase(params: event.toLoginRequest());
      if (dataState is DataSuccess) {
        user = dataState.data;
        emit(
          const RemoteAuthDone()
        );
      } else if (dataState is DataFailed) {
        emit(
          RemoteAuthError(dataState.error!)
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("failed to login $e");
      }
    }
  }

  void onRegisterEvents(RegisterEvent event, Emitter<RemoteAuthState> emit) async {
    emit(const RemoteAuthLoading());
    try {
      event.userModel.token = _firebaseApi.token;
      final dataState = await _createUserUseCase(params: event.userModel);

      if (dataState is DataSuccess) {
        emit(
            const RemoteAuthDone()
        );
      } else if (dataState is DataFailed) {
        emit(
            RemoteAuthError(dataState.error!)
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("failed to register $e");
      }
    }
  }
}