import 'package:k_eventy/core/constants/constants.dart';
import 'package:k_eventy/features/event/data/models/event.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'event_api_service.g.dart';

@RestApi(baseUrl: eventsAPIBaseURL)
abstract class EventApiService {
  factory EventApiService(Dio dio) = _EventApiService;

  @GET('/events')
  Future<HttpResponse<List<EventModel>>> getEvents();
}