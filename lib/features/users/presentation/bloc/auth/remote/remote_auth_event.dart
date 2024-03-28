
import 'dart:io';

import 'package:k_eventy/features/users/data/models/user.dart';
import 'package:k_eventy/features/users/data/request/login_request.dart';

abstract class RemoteAuthEvent {
  const RemoteAuthEvent();
}

class LoginEvents extends RemoteAuthEvent {
  final String username;
  final String password;
  const LoginEvents(this.username, this.password);
}

extension LoginEventsExtension on LoginEvents {
  LoginRequest toLoginRequest() {
    return LoginRequest(username, password);
  }
}

class RegisterEvent extends RemoteAuthEvent {
  final UserModel userModel;

  const RegisterEvent(
      this.userModel
  );
}
