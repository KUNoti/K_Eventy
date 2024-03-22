import 'package:ar_location_view/ar_location_view.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:k_eventy/features/event/presentation/widgets/AR/annotation_view.dart';
import 'package:k_eventy/features/event/presentation/widgets/AR/annotations.dart';

class ARSection extends StatefulWidget {
  const ARSection({super.key});

  @override
  State<ARSection> createState() => _ARSectionState();
}

class _ARSectionState extends State<ARSection> {
  List<Annotation> annotations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArLocationWidget(
        annotations: annotations,
        showDebugInfoSensor: false,

        onLocationChange: (Position position) {
          Future.delayed(const Duration(seconds: 5), () {
            annotations = fakeAnnotation(position: position, numberMaxPoi: 50);
            setState(() {});
          });
        },
        annotationViewBuilder: (context, annotation) {
          return AnnotationView(
            key: ValueKey(annotation.uid),
            annotation: annotation as Annotation,
          );
        },
      ),
    );
  }
}
