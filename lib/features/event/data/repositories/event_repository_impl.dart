
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:k_eventy/core/resources/data_state.dart';
import 'package:k_eventy/features/event/data/data_sources/remote/event_api_service.dart';
import 'package:k_eventy/features/event/data/models/event.dart';
import 'package:k_eventy/features/event/data/request/follow_request.dart';
import 'package:k_eventy/features/event/domain/entities/event.dart';
import 'package:k_eventy/features/event/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventApiService _eventApiService;
  EventRepositoryImpl(this._eventApiService);

  @override
  Future<DataState<void>> createEvent(EventEntity event) async {
    try {
      EventModel eventModel = EventModel.fromEntity(event);
      print(eventModel.startDateTime!.toIso8601String());
      final httpResponse = await _eventApiService.createEvent(
        eventModel.title!,
        eventModel.latitude!,
        eventModel.longitude!,
        "${eventModel.startDateTime!.toIso8601String()}Z",
        "${eventModel.endDateTime!.toIso8601String()}Z",
        eventModel.price!,
        eventModel.creator!,
        eventModel.detail!,
        eventModel.locationName!,
        eventModel.needRegis!,
        eventModel.imageFile!,
        eventModel.tag!
      );

      if(httpResponse.response.statusCode == HttpStatus.ok) {
        return const DataSuccess<void>(null);
      } else {
        return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioExceptionType.badResponse,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioException catch(e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<EventModel>>> getEvents() async {
    try {
      final httpResponse = await _eventApiService.getEvents();

      if(httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions
          )
        );
      }
    } on DioException catch(e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> followEvent(FollowRequest request) async {
    try {
      final httpResponse = await _eventApiService.followEvent(request);
      if(httpResponse.response.statusCode == HttpStatus.ok) {
        return const DataSuccess<void>(null);
      } else {
        return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioExceptionType.badResponse,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioException catch(e) {
      return DataFailed(e);
    }
  }
}
