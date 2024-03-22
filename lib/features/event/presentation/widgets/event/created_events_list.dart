import 'package:flutter/material.dart';
import 'package:k_eventy/features/event/presentation/widgets/event/my_event_card.dart';

class CreatedEventsList extends StatelessWidget {
  const CreatedEventsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy list of created events
    List<String> createdEvents =
    List.generate(5, (index) => 'Created Event $index');

    return SizedBox(
      height: 200, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: createdEvents.length,
        itemBuilder: (context, index) {
          return MyEventCard(eventName: createdEvents[index]);
        },
      ),
    );
  }
}