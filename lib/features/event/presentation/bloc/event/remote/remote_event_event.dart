import 'package:k_eventy/features/event/domain/entities/event.dart';

abstract class RemoteEventsEvent {
  const RemoteEventsEvent();
}

class GetEvents extends RemoteEventsEvent {
  const GetEvents();
}

class CreateEvent extends RemoteEventsEvent {
  final EventEntity eventEntity;
  const CreateEvent(this.eventEntity);
}