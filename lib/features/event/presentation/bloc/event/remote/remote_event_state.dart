
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:k_eventy/features/event/domain/entities/event.dart';

abstract class RemoteEventsState extends Equatable {
  final List<EventEntity> ? events;
  final DioException ? exception;

  const RemoteEventsState({this.events, this.exception});

  @override
  List<Object> get props => [events!, exception!];
}

class RemoteEventsLoading extends RemoteEventsState {
  const RemoteEventsLoading();
}

class RemoteEventsDone extends RemoteEventsState {
  const RemoteEventsDone(List<EventEntity> events) : super(events: events);
}

class RemoteEventsError extends RemoteEventsState {
  const RemoteEventsError(DioException exception) : super(exception: exception);
}