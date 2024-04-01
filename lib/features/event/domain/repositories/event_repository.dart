
import 'package:k_eventy/core/resources/data_state.dart';
import 'package:k_eventy/features/event/data/request/follow_request.dart';
import 'package:k_eventy/features/event/domain/entities/event.dart';

abstract class EventRepository {
  Future<DataState<List<EventEntity>>> getEvents();

  Future<DataState<void>> createEvent(EventEntity event);

  Future<DataState<void>> followEvent(FollowRequest request);

  Future<DataState<void>> unFollowEvent(FollowRequest request);
}