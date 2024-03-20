import 'package:k_eventy/features/event/data/models/event_model.dart';
import 'package:k_eventy/features/event/domain/entities/event.dart';
import '../repositories/event_repository.dart';

class GetEventsUseCase {
  final EventRepository repository;

  GetEventsUseCase(this.repository);

  Future<List<Event>> call() async {
    return await repository.fetchEvents();
  }
}