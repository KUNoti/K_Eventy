import 'package:ar_location_view/ar_location_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:k_eventy/annotations.dart';
import 'package:k_eventy/annotation_view.dart';
import 'package:k_eventy/event.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Annotation> annotations = [];

  @override
  void initState() {
    super.initState();
    _mockEvents();
    // _fetchEvents();
  }

  void _mockEvents() {
    List<Event> events = [
      Event(
        id: 1,
        latitude: 13.8517,
        longitude: 100.5678,
        title: "Music Concert",
        image: "https://mpics.mgronline.com/pics/Images/560000007342901.JPEG",
        creator: "InnovateTech",
        detail: "Explore the latest in technology",
        tag: "Music",
        locationName: "Concert Hall",
        startDateTime: DateTime.parse("2024-02-10T18:00:00Z"),
        endDateTime: DateTime.parse("2024-02-12T22:00:00Z"),
      ),
      Event(
        id: 2,
        latitude: 13.8495,
        longitude: 100.569,
        title: "Sport Festival",
        image:
            "https://scontent.fbkk13-2.fna.fbcdn.net/v/t1.6435-9/142000152_2716453381999537_4277309584130064089_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=7f8c78&_nc_ohc=bVc21S_H_IsAX8pm_Sk&_nc_ht=scontent.fbkk13-2.fna&oh=00_AfAiwkIVcN4TuVz2GKRbmh3scaY0d-CfJ5nGVObVH8kxXA&oe=65E5A270",
        creator: "InnovateTech",
        detail: "Indulge in a variety of sporting activities",
        tag: "Sport",
        locationName: "City Square",
        startDateTime: DateTime.parse("2024-03-05T12:00:00Z"),
        endDateTime: DateTime.parse("2024-03-07T20:00:00Z"),
      ),
      // Add more events here...
    ];

    // Convert events to annotations
    List<Annotation> newAnnotations = events
        .map((event) => Annotation(
              uid: const Uuid().v1(),
              position: Position(
                latitude: event.latitude,
                longitude: event.longitude,
                timestamp: DateTime.now(),
                accuracy: 1,
                altitude: 1,
                heading: 1,
                speed: 1,
                speedAccuracy: 1,
                altitudeAccuracy: 5,
                headingAccuracy: 5,
              ),
              type: getRandomAnnotation(),
              eventTitle: event.title,
            ))
        .toList();

    // Update the annotations list
    setState(() {
      annotations = newAnnotations;
    });
  }

  Future<void> _fetchEvents() async {
    try {
      // Make an HTTP GET request to fetch events
      Response response = await Dio().get('http://localhost:8000/events');
      print("response ${response.data}");
      // Parse the response data into a list of events
      List<Event> events = (response.data as List)
          .map((eventJson) => Event.fromJson(eventJson))
          .toList();
      print("events ${events}");
      // Convert events to annotations
      List<Annotation> newAnnotations = events
          .map((event) => Annotation(
                uid: const Uuid().v1(),
                position: Position(
                  latitude: event.latitude,
                  longitude: event.longitude,
                  timestamp: DateTime.now(),
                  accuracy: 1,
                  altitude: 1,
                  heading: 1,
                  speed: 1,
                  speedAccuracy: 1,
                  altitudeAccuracy: 5,
                  headingAccuracy: 5,
                ),
                type: getRandomAnnotation(),
                eventTitle: event.title,
              ))
          .toList();

      // Update the annotations list and refresh the UI
      setState(() {
        annotations = newAnnotations;
      });
    } catch (e) {
      print('Error fetching events: $e');
      // Handle errors, e.g., show a message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ArLocationWidget(
          annotations: annotations,
          showDebugInfoSensor: false,
          annotationViewBuilder: (context, annotation) {
            return AnnotationView(
              key: ValueKey(annotation.uid),
              annotation: annotation as Annotation,
            );
          },
          onLocationChange: (Position position) {
            Future.delayed(const Duration(seconds: 5), () {
              // annotations = fakeAnnotation(position: position, numberMaxPoi: 5);
              setState(() {});
            });
          },
        ),
      ),
    );
  }
}
