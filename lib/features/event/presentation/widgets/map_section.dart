import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:k_eventy/features/event/data/repositories/event_repository_impl.dart';
import 'package:k_eventy/features/event/domain/entities/event.dart';
import 'package:k_eventy/features/event/presentation/widgets/custom_marker.dart';

import '../../data/models/event_model.dart';
class MapSection extends StatefulWidget {
  const MapSection({super.key});

  @override
  State<MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(13.854529, 100.570012);
  List<Event> events = [];
  Set<Marker> _markers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _fetchEvents();
  }

  void _fetchEvents() async {
    try {
      var eventRepository = EventRepositoryImpl();
      List<EventModel> eventModels = await eventRepository.fetchEvents();

      setState(() {
        events = eventModels.map((eventModel) => eventModel.toDomain()).toList();
        _loadMarkers(); // Call _loadMarkers inside setState to ensure events are populated before loading markers
      });
    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  void _loadMarkers() async {
    for (var event in events) {
      var marker = await CustomMarker.buildMarkerFromUrl(
        id: event.id.toString(),
        url: event.image,
        position: LatLng(event.latitude, event.longitude),
      );

      if (marker != null) {
        setState(() {
          _markers.add(marker);
        });
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 16.0,
        ),
          // markers: _markers,
        gestureRecognizers: Set()
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))

      ),
    );
  }
}
