import 'package:k_eventy/features/event/data/request/follow_request.dart';
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

class FollowEvent extends RemoteEventsEvent {
  final int userId;
  final int eventId;
  const FollowEvent(this.userId, this.eventId);
}

extension FollowEventExtension on FollowEvent {
  FollowRequest toFollowRequest() {
    return FollowRequest(userId, eventId);
  }
}

class UnFollowEvent extends RemoteEventsEvent {
  final int userId;
  final int eventId;
  const UnFollowEvent(this.userId, this.eventId);
}

extension UnFollowEventExtension on UnFollowEvent {
  FollowRequest toFollowRequest() {
    return FollowRequest(userId, eventId);
  }
}

