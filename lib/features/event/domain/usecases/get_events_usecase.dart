
import 'package:k_eventy/core/resources/data_state.dart';
import 'package:k_eventy/core/usecase/usecase.dart';
import 'package:k_eventy/features/event/domain/entities/event.dart';
import 'package:k_eventy/features/event/domain/repositories/event_repository.dart';

class GetEventsUseCase implements UseCase<DataState<List<EventEntity>>, void>{
  final EventRepository _eventRepository;
  GetEventsUseCase(this._eventRepository);

  @override
  Future<DataState<List<EventEntity>>> call({void params}) {
    return _eventRepository.getEvents();
  }
}