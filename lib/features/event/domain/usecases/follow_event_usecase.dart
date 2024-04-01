import 'package:dio/dio.dart';
import 'package:k_eventy/core/resources/data_state.dart';
import 'package:k_eventy/core/usecase/usecase.dart';
import 'package:k_eventy/features/event/data/request/follow_request.dart';
import 'package:k_eventy/features/event/domain/repositories/event_repository.dart';

class FollowEventUseCase implements UseCase<DataState<void>, FollowRequest> {
  final EventRepository _eventRepository;
  FollowEventUseCase(this._eventRepository);

  @override
  Future<DataState<void>> call({FollowRequest? params}) {
    if (params == null) {
      return Future(() => DataFailed(
        DioException(
          requestOptions: RequestOptions(
            data: "request is null"
          )
        )
      ));
    }

    return _eventRepository.followEvent(params);
  }
}