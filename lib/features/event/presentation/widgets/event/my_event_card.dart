import 'package:flutter/material.dart';

class MyEventCard extends StatelessWidget {
  final String eventName;

  const MyEventCard({Key? key, required this.eventName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 150, // Adjust the width as needed
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                color: Colors.grey[300], // Placeholder for event details
                child: const Center(
                  child: Text(
                    'Event details',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}