import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_eventy/config/route/navigation_bottom.dart';
import 'package:k_eventy/config/theme/app_themes.dart';
import 'package:k_eventy/features/event/presentation/bloc/event/remote/remote_event_bloc.dart';
import 'package:k_eventy/features/event/presentation/bloc/event/remote/remote_event_event.dart';
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
    return BlocProvider<RemoteEventsBloc>(
      create: (context) => sl()..add(const GetEvents()),
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: const NavigationBottom(),
      ),
    );
  }
}


