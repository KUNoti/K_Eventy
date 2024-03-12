class Event {
  final int id;
  final double latitude;
  final double longitude;
  final String title;
  final String image;
  final String creator;
  final String detail;
  final String tag;
  final String locationName;
  final DateTime startDateTime;
  final DateTime endDateTime;

  Event({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.title,
    required this.image,
    required this.creator,
    required this.detail,
    required this.tag,
    required this.locationName,
    required this.startDateTime,
    required this.endDateTime,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
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
}
