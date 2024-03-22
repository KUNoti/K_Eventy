import 'package:flutter/material.dart';
import 'package:k_eventy/features/event/presentation/widgets/AR/ar_section.dart';
import 'package:k_eventy/features/event/presentation/widgets/map/map_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          // AR Section 2/3
          Expanded(
              flex: 2,
              child: ARSection()
          ),

          // Map Section 1/3
           Expanded(
            flex: 1,
            child: MapSection(events: [])
          ),
        ],
      ),
    );
  }
}
