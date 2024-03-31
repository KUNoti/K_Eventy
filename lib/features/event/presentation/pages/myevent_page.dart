import 'package:flutter/material.dart';
import 'package:k_eventy/features/event/presentation/widgets/event/created_events_list.dart';
import 'package:k_eventy/features/event/presentation/widgets/event/follow_events_list.dart';
import 'package:k_eventy/features/event/presentation/widgets/event/notification_list.dart';

class MyEventsPage extends StatelessWidget {
  const MyEventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Events'),
      ),
      body: _buildBody(context)
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Following',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            FollowingEventsList(),

            const SizedBox(height: 16),

            Text(
              'Created Events',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const CreatedEventsList(),

            const SizedBox(height: 16),
            Text(
              'Notifications',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const NotificationsList(),
          ],
        ),
      ),
    );
  }
}






