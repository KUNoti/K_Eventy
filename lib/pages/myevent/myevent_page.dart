import 'package:flutter/material.dart';

class MyEventsPage extends StatelessWidget {
  const MyEventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Events'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Following',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 8),
              FollowingEvents(), // Display Following events

              SizedBox(height: 16),

              Text(
                'Created Events',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 8),
              CreatedEvents(), // Display Created events
            ],
          ),
        ),
      ),
    );
  }
}

class FollowingEvents extends StatelessWidget {
  const FollowingEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy list of following events
    List<String> followingEvents = List.generate(5, (index) => 'Following Event $index');

    return SizedBox(
      height: 200, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: followingEvents.length,
        itemBuilder: (context, index) {
          return EventCard(eventName: followingEvents[index]);
        },
      ),
    );
  }
}

class CreatedEvents extends StatelessWidget {
  const CreatedEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy list of created events
    List<String> createdEvents = List.generate(5, (index) => 'Created Event $index');

    return SizedBox(
      height: 200, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: createdEvents.length,
        itemBuilder: (context, index) {
          return EventCard(eventName: createdEvents[index]);
        },
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String eventName;

  const EventCard({Key? key, required this.eventName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 150, // Adjust the width as needed
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: Container(
                color: Colors.grey[300], // Placeholder for event details
                child: Center(
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
