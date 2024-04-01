import 'dart:io';

import 'package:k_eventy/core/constants/constants.dart';
import 'package:k_eventy/features/event/data/models/event.dart';
import 'package:k_eventy/features/event/data/request/follow_request.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'event_api_service.g.dart';

@RestApi(baseUrl: APIBaseAndroidURL)
abstract class EventApiService {
  factory EventApiService(Dio dio) = _EventApiService;

  @GET('/api/event/events')
  Future<HttpResponse<List<EventModel>>> getEvents();

  @POST('/api/event/create')
  @MultiPart()
  Future<HttpResponse<void>> createEvent(
      @Part(name: "title") String title,
      @Part(name: "latitude") num latitude,
      @Part(name: "longitude") num longitude,
      @Part(name: "start_date_time") String stateDate,
      @Part(name: "end_date_time") String endDate,
      @Part(name: "price") num price,
      @Part(name: "creator") int creator,
      @Part(name: "detail") String detail,
      @Part(name: "location_name") String locationName,
      @Part(name: "need_regis") bool needRegis,
      @Part(name: "image_file") File imageFile,
      @Part(name: "tag") String tag,
  );

  @POST('/api/event/follow')
  Future<HttpResponse<void>> followEvent(
      @Body() FollowRequest request
  );
}