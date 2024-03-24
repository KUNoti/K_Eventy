import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_eventy/core/resources/data_state.dart';
import 'package:k_eventy/features/event/domain/usecases/create_event_usecase.dart';
import 'package:k_eventy/features/event/domain/usecases/get_events_usecase.dart';
import 'package:k_eventy/features/event/presentation/bloc/event/remote/remote_event_event.dart';
import 'package:k_eventy/features/event/presentation/bloc/event/remote/remote_event_state.dart';

class RemoteEventsBloc extends Bloc<RemoteEventsEvent, RemoteEventsState> {
  final GetEventsUseCase _getEventUseCase;
  final CreateEventUseCase _createEventUseCase;

  RemoteEventsBloc(this._getEventUseCase, this._createEventUseCase) : super(const RemoteEventsLoading()) {
    on <GetEvents> (onGetEvents);
    on <CreateEvent> (onCreateEvent);
  }

  void onGetEvents(GetEvents event, Emitter<RemoteEventsState> emit) async {
    try {
      final dataState = await _getEventUseCase();

      if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
        emit(
            RemoteEventsDone(dataState.data!)
        );
      }

      if (dataState is DataFailed) {
        emit(
            RemoteEventsError(dataState.error!)
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("failed to get event $e");
      }
    }
  }

  void onCreateEvent(CreateEvent event, Emitter<RemoteEventsState> emit) async {
    try {
      final dataState = await _createEventUseCase(params: event.eventEntity);

      if (dataState is DataSuccess) {
        // reload
        add(const GetEvents());

        emit(const RemoteEventsDone([]));
      }

      if (dataState is DataFailed) {
        emit(RemoteEventsError(dataState.error!));
      }

    } catch (e) {
      if (kDebugMode) {
        print("failed to create event $e");
      }
    }
  }
}