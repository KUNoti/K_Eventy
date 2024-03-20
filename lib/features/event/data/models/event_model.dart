import 'package:k_eventy/features/event/domain/entities/event.dart';

class EventModel extends Event {
  EventModel({
    required int id,
    required double latitude,
    required double longitude,
    required String title,
    required String image,
    required String creator,
    required String detail,
    required String tag,
    required String locationName,
    required DateTime startDateTime,
    required DateTime endDateTime,
  }) : super(
    id: id,
    latitude: latitude,
    longitude: longitude,
    title: title,
    image: image,
    creator: creator,
    detail: detail,
    tag: tag,
    locationName: locationName,
    startDateTime: startDateTime,
    endDateTime: endDateTime,
  );

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      title: json['title'],
      image: json['image'],
      creator: json['creator'],
      detail: json['detail'],
      tag: json['tag'],
      locationName: json['locationName'],
      startDateTime: DateTime.parse(json['startDateTime']),
      endDateTime: DateTime.parse(json['endDateTime']),
    );
  }

  Event toDomain() {
    return Event(
      id: id,
      latitude: latitude,
      longitude: longitude,
      title: title,
      image: image,
      creator: creator,
      detail: detail,
      tag: tag,
      locationName: locationName,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
    );
  }
}