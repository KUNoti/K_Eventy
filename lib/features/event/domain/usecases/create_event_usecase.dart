
import 'package:dio/dio.dart';
import 'package:k_eventy/core/resources/data_state.dart';
import 'package:k_eventy/core/usecase/usecase.dart';
import 'package:k_eventy/features/event/domain/entities/event.dart';
import 'package:k_eventy/features/event/domain/repositories/event_repository.dart';

class CreateEventUseCase implements UseCase<DataState<void>, EventEntity> {
  final EventRepository _eventRepository;
  CreateEventUseCase(this._eventRepository);

  @override
  Future<DataState<void>> call({EventEntity? params}) {
    if (params == null) {
      return Future(() => DataFailed(
          DioException(
              requestOptions: RequestOptions(
                data: "eventEntity is null"
              )
          )
      ));
    }

    return _eventRepository.createEvent(params);
  }
}