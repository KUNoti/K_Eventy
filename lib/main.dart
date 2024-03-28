import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_eventy/config/theme/app_themes.dart';
import 'package:k_eventy/features/users/presentation/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:k_eventy/features/users/presentation/pages/login_page.dart';
import 'package:k_eventy/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteAuthBloc>(
      create: (context) => sl<RemoteAuthBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: LoginPage(),
      ),
    );
  }
}


