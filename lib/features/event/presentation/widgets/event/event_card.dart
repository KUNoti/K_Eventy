import 'package:flutter/material.dart';
import 'package:k_eventy/config/theme/colors_sample.dart';
import 'package:k_eventy/core/constants/constants.dart';
import 'package:k_eventy/features/event/data/models/event.dart';
import 'package:k_eventy/features/event/domain/entities/event.dart';
import 'package:k_eventy/features/event/presentation/pages/event_page.dart';

class EventCard extends StatelessWidget {
  EventEntity? event;
  EventCard({Key? key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: _buildCard(event!)
    );
  }

  Widget _buildCard(EventEntity event) {
    return Card(
      color: const Color.fromRGBO(238, 242, 249, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
            event?.image ?? kDefaultImage,
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  event.title!,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey[800],
                  ),
                ),
                Container(height: 10),
                Text(
                  event.detail!,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                ),

                Row(
                  children: <Widget>[
                    const Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.transparent,
                      ),
                      child: const Text(
                        "SHARE",
                        style: TextStyle(color: MyColorsSample.accent),
                      ),
                      onPressed: () {},
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.transparent,
                      ),
                      child: const Text(
                        "EXPLORE",
                        style: TextStyle(color: MyColorsSample.accent),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(height: 5),
        ],
      ),
    );
  }
}
