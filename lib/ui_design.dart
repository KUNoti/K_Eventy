import 'package:flutter/material.dart';
import 'package:k_eventy/components/event_card.dart';
import 'package:k_eventy/event.dart';
import 'package:k_eventy/navigation/navigation_bottom.dart';
import 'package:k_eventy/pages/auth/login_page.dart';
import 'package:k_eventy/pages/auth/register_page.dart';
import 'package:k_eventy/pages/home/ar_page.dart';
import 'package:k_eventy/pages/home/ar_setting.dart';
import 'package:k_eventy/pages/home/map_section.dart';
import 'package:k_eventy/pages/notification/notification_page.dart';
import 'package:k_eventy/pages/user/user_setting.dart';

class UIDesign extends StatefulWidget {
  const UIDesign({super.key});

  @override
  State<UIDesign> createState() => _UIDesignState();
}

class _UIDesignState extends State<UIDesign> {
  List<Event> mockEvents = [
    Event(
      id: 1,
      latitude: 37.7749,
      longitude: -122.4194,
      title: "Event 1",
      image: "https://via.placeholder.com/150",
      creator: "Creator 1",
      detail: "Event 1 details",
      tag: "Tag 1",
      locationName: "Location 1",
      startDateTime: DateTime.now(),
      endDateTime: DateTime.now().add(Duration(hours: 2)),
    ),
    Event(
      id: 2,
      latitude: 40.7128,
      longitude: -74.0060,
      title: "Event 2",
      image: "https://via.placeholder.com/150",
      creator: "Creator 2",
      detail: "Event 2 details",
      tag: "Tag 2",
      locationName: "Location 2",
      startDateTime: DateTime.now().add(Duration(days: 1)),
      endDateTime: DateTime.now().add(Duration(days: 1, hours: 2)),
    ),
    Event(
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
    ),
  ];

  void navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void navigateToRegisterPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  void navigateToARPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ARPage()),
    );
  }

  void navigateToMapSection(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MapSection()),
    );
  }

  void navigateToEventCard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EventCard(
                event: mockEvents.first,
              )),
    );
  }

  void navigateToSearchPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NavigationBottom()),
    );
  }

  void navigateToUserSetting(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserSettingPage()),
    );
  }

  void navigateToARSetting(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ARSetting()),
    );
  }

  void navigateToNotification(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Design'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () => navigateToLoginPage(context),
            child: const Text(
              'Log In',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => navigateToRegisterPage(context),
            child: const Text(
              'Register',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => navigateToARPage(context),
            child: const Text(
              'AR Section',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => navigateToMapSection(context),
            child: const Text(
              'Map Section',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => navigateToEventCard(context),
            child: const Text(
              'Event Card',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => navigateToSearchPage(context),
            child: const Text(
              'Navigation bottom',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => navigateToNotification(context),
            child: const Text(
              'Notification page',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => navigateToUserSetting(context),
            child: const Text(
              'User setting',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => navigateToARSetting(context),
            child: const Text(
              'AR Setting',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => navigateToARSetting(context),
            child: const Text(
              'My Event',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => navigateToARSetting(context),
            child: const Text(
              'Event Approve (Creator)',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => navigateToARSetting(context),
            child: const Text(
              'Event (เข้าร่วมกิจกรรม)',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
