import 'package:flutter/material.dart';
import 'package:k_eventy/core/constants/constants.dart';
import 'package:k_eventy/features/event/data/models/event.dart';
import 'package:k_eventy/features/event/domain/entities/event.dart';
import 'package:k_eventy/features/event/presentation/pages/event_page.dart';

class EventCard extends StatelessWidget {
  EventEntity? event;
  EventCard({Key? key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EventModel mockEvent = EventModel(
      latitude: 34.0522,
      longitude: -118.2437,
      title: "Event 3",
      image: "https://via.placeholder.com/150",
      creator: 1,
      detail: "Event 3 details",
      tag: "Tag 3",
      locationName: "Location 3",
      startDateTime: DateTime.now().add(const Duration(days: 2)),
      endDateTime: DateTime.now().add(const Duration(days: 2, hours: 2)),
    );

    return GestureDetector(
      onTap: () {
        // Navigate to the event page when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventPage(
              event: event,
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
        child: _buildCard(event!),
      ),
    );
  }

  Widget _buildCard(EventEntity event) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: Image.network(
            event.image ?? kDefaultImage,
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
                event.title ?? "",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Location: ${event.locationName}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
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
    );
  }
}
