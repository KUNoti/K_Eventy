import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k_eventy/features/event/domain/entities/event.dart';
import 'package:k_eventy/features/event/presentation/widgets/event/register_form.dart';

class EventPage extends StatelessWidget {
  final EventEntity? event;

  const EventPage({Key? key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _buildAppbar(context),
      body: Column(
        children: [
          _buildEventCard(context),
          _buildDescriptionSection(),
          _buildButtonSection(context),
        ],
      ),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(event?.title ?? "Event") ,
    );
  }

  Widget _buildEventCard(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              event?.image ?? "",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),

          // Middle widget
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Location: ${event?.locationName}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Creator: ${event?.creator}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.redAccent),
                onPressed: () {
                  // Add your onPressed logic here
                },
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
            indent: 3,
            endIndent: 3,
          ),
          const SizedBox(height: 8),
          Text(
            event?.detail ?? '',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.date_range),
            title: const Text(
              'Start Date',
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text(
              _formatDate(event?.startDateTime),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.date_range),
            title: const Text(
              'End Date',
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text(
              _formatDate(event?.endDateTime),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white, // Text color
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return  Container(
                            height: 200,
                            color: Colors.amber,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  RegisterForm()
                                ],
                              ),
                            ),
                          );
                        }
                    );
                  },
                ),
              ),
              const SizedBox(width: 15),
              Flexible(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Text(
                    "Navigate",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white, // Text color
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? dateTime) {
    return dateTime != null ? DateFormat.yMMMMd().add_jm().format(dateTime) : '';
  }
}