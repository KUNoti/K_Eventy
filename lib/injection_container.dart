
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:k_eventy/core/firebase/notification/firebase_api.dart';
import 'package:k_eventy/features/event/data/data_sources/remote/event_api_service.dart';
import 'package:k_eventy/features/event/data/repositories/event_repository_impl.dart';
import 'package:k_eventy/features/event/domain/repositories/event_repository.dart';
import 'package:k_eventy/features/event/domain/usecases/create_event_usecase.dart';
import 'package:k_eventy/features/event/domain/usecases/follow_event_usecase.dart';
import 'package:k_eventy/features/event/domain/usecases/get_events_usecase.dart';
import 'package:k_eventy/features/event/presentation/bloc/event/remote/remote_event_bloc.dart';
import 'package:k_eventy/features/users/data/data_sources/remote/user_service.dart';
import 'package:k_eventy/features/users/data/repositories/user_repository_impl.dart';
import 'package:k_eventy/features/users/domain/repositories/user_repository.dart';
import 'package:k_eventy/features/users/domain/usecases/create_user_usecase.dart';
import 'package:k_eventy/features/users/domain/usecases/login_user_usercase.dart';
import 'package:k_eventy/features/users/presentation/bloc/auth/remote/remote_auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  
  // Dio 
  sl.registerSingleton<Dio>(Dio());

  // FireBase
  sl.registerSingleton<FirebaseApi>(FirebaseApi());
  
  // Dependencies
  sl.registerSingleton<EventApiService>(EventApiService(sl()));
  sl.registerSingleton<UserService>(UserService(sl()));

  sl.registerSingleton<EventRepository>(
    EventRepositoryImpl(sl())
  );

  sl.registerSingleton<UserRepository>(
    UserRepositoryImpl(sl())
  );

  // UseCases
  sl.registerSingleton<GetEventsUseCase>(
    GetEventsUseCase(sl())
  );

  sl.registerSingleton<CreateEventUseCase>(
    CreateEventUseCase(sl())
  );

  sl.registerSingleton<FollowEventUseCase>(
    FollowEventUseCase(sl())
  );

  sl.registerSingleton<CreateUserUseCase>(
    CreateUserUseCase(sl())
  );

  sl.registerSingleton<LoginUserUseCase>(
    LoginUserUseCase(sl())
  );

  // Bloc
  sl.registerFactory<RemoteEventsBloc>(
    () => RemoteEventsBloc(sl(), sl(), sl())
  );

  sl.registerFactory<RemoteAuthBloc>(
    () => RemoteAuthBloc(sl(), sl(), sl())
  );
}