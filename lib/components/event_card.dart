import 'package:flutter/material.dart';
import 'package:k_eventy/features/event/data/models/event_model.dart';
import 'package:k_eventy/features/event/presentation/pages/event_page.dart';

class EventCard extends StatelessWidget {
  const EventCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EventModel mockEvent = EventModel(
      id: 3,
      latitude: 34.0522,
      longitude: -118.2437,
      title: "Event 3",
      image: "https://via.placeholder.com/150",
      creator: "Creator 3",
      detail: "Event 3 details",
      tag: "Tag 3",
      locationName: "Location 3",
      startDateTime: DateTime.now().add(Duration(days: 2)),
      endDateTime: DateTime.now().add(Duration(days: 2, hours: 2)),
    );

    return GestureDetector(
      onTap: () {
        // Navigate to the event page when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventPage(
              event: mockEvent,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                mockEvent.image,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mockEvent.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Location: ${mockEvent.locationName}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Status: Active',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
