import 'package:flutter/material.dart';
import 'package:k_eventy/features/users/presentation/pages/login_page.dart';
import 'package:k_eventy/navigation/navigation_bottom.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // _fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationBottom(),
    );
  }
}
