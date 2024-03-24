
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:k_eventy/features/event/data/data_sources/remote/event_api_service.dart';
import 'package:k_eventy/features/event/data/repositories/event_repository_impl.dart';
import 'package:k_eventy/features/event/domain/repositories/event_repository.dart';
import 'package:k_eventy/features/event/domain/usecases/create_event_usecase.dart';
import 'package:k_eventy/features/event/domain/usecases/get_events_usecase.dart';
import 'package:k_eventy/features/event/presentation/bloc/event/remote/remote_event_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  
  // Dio 
  sl.registerSingleton<Dio>(Dio());
  
  // Dependencies
  sl.registerSingleton<EventApiService>(EventApiService(sl()));
  
  sl.registerSingleton<EventRepository>(
    EventRepositoryImpl(sl())
  );
  
  // UseCases
  sl.registerSingleton<GetEventsUseCase>(
    GetEventsUseCase(sl())
  );

  sl.registerSingleton(
    CreateEventUseCase(sl())
  );
  
  sl.registerFactory<RemoteEventsBloc>(
    () => RemoteEventsBloc(sl(), sl())
  );
}