import 'package:k_eventy/core/constants/constants.dart';
import 'package:k_eventy/features/event/domain/entities/event.dart';

class EventModel extends EventEntity {
   const EventModel({
    String? title,
    num? latitude,
    num? longitude,
    DateTime? startDateTime,
    DateTime? endDateTime,
    num? price,
    String? image,
    int? creator,
    String? detail,
    String? tag,
    String? locationName,
    bool? needRegis,
  }) : super(
    title: title,
    latitude: latitude,
    longitude: longitude,
    startDateTime: startDateTime,
    endDateTime: endDateTime,
    price: price,
    image: image,
    creator: creator,
    detail: detail,
    tag: tag,
    locationName: locationName,
    needRegis: needRegis,
  );

  factory EventModel.fromJson(Map<String, dynamic> map){
    return EventModel(
      title: map['title'] ?? "",
      // latitude: map['latitude'] ?? 13.5,
      // longitude: map['longitude'] ?? 120.0,
      startDateTime: DateTime.parse(map['start_date']),
      endDateTime: DateTime.parse(map['end_date']),
      price: map['price'] ?? 0.0,
      image: map['image'] != null && map['image'] != "" ? map['image'] : kDefaultImage,
      creator: map['creator'] ?? 0,
      detail: map['detail'] ?? "",
      locationName: map['location_name'] ?? "",
      needRegis: map['need_regis'] ?? false
    );
  }

  factory EventModel.fromEntity(EventEntity entity) {
    return EventModel(
        title: entity.title,
        latitude: entity.latitude,
        longitude: entity.longitude,
        startDateTime: entity.startDateTime,
        endDateTime: entity.endDateTime,
        price: entity.price,
        image: entity.image,
        creator: entity.creator,
        detail: entity.detail,
        locationName: entity.locationName,
        needRegis: entity.needRegis
    );
  }
}