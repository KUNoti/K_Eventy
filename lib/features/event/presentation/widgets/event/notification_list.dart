import 'package:flutter/material.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy list of notifications
    List<String> notifications =
    List.generate(10, (index) => 'Notification $index');

    return SizedBox(
      height: 300, // Adjust the height as needed
      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index]),
          );
        },
      ),
    );
  }
}