import 'package:flutter/material.dart';
import 'package:k_eventy/features/event/presentation/widgets/AR/annotations.dart';

class AnnotationView extends StatelessWidget {
  const AnnotationView({
    Key? key,
    required this.annotation,
  }) : super(key: key);

  final Annotation annotation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: typeFactory(annotation.type),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    annotation.type.toString().substring(15),
                    maxLines: 1,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${annotation.distanceFromUser.toInt()} m',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget typeFactory(AnnotationType type) {
    IconData iconData = Icons.ac_unit_outlined;
    Color color = Colors.teal;
    switch (type) {
      case AnnotationType.KU:
        iconData = Icons.cast_for_education;
        color = Colors.red;
        break;
      case AnnotationType.Festival:
        iconData = Icons.festival;
        color = Colors.green;
        break;
      case AnnotationType.Music:
        iconData = Icons.music_note;
        color = Colors.blue;
        break;
      case AnnotationType.Sport:
        iconData = Icons.sports_basketball;
        color = Colors.blue;
    }
    return Icon(
      iconData,
      size: 40,
      color: color,
    );
  }
}
