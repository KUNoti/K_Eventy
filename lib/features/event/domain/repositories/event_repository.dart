import 'package:k_eventy/features/event/domain/entities/event.dart';

abstract class EventRepository {
  Future<List<Event>> fetchEvents();
}