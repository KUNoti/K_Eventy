import 'package:flutter/material.dart';
import 'package:k_eventy/features/event/presentation/widgets/event/my_event_card.dart';

class FollowingEventsList extends StatelessWidget {
  const FollowingEventsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy list of following events
    List<String> followingEvents =
    List.generate(5, (index) => 'Following Event $index');

    return SizedBox(
      height: 200, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: followingEvents.length,
        itemBuilder: (context, index) {
          return MyEventCard(eventName: followingEvents[index]);
        },
      ),
    );
  }
}