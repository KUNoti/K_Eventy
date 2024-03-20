import '../../domain/repositories/event_repository.dart';
import 'package:dio/dio.dart';

import '../models/event_model.dart';

class EventRepositoryImpl implements EventRepository {
  final Dio dio = Dio();

  EventRepositoryImpl();

  @override
  Future<List<EventModel>> fetchEvents() async {
    try {
      final response = await dio.get('http://127.0.0.1:8000/events');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((e) => EventModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      throw Exception('Failed to load events due to an error: $e');
    }
  }
}