import 'package:flutter/material.dart';
import 'package:k_eventy/features/event/presentation/widgets/map_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 0,
            child: Container(
              color: Colors.blue,
              child: const Center(
                child: Text('2/3'),
              ),
            ),
          ),

          // AR Section 2/3
          // Expanded(
          //     flex: 2,
          //     child: ARSection()
          // ),

          // Map Section 1/3
          const Expanded(
            flex: 1,
            // child: MapSection()
            child: Placeholder(),
          ),
        ],
      ),
    );
  }
}
