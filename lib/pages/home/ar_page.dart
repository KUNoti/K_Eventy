import 'package:ar_location_view/ar_location_widget.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:k_eventy/pages/home/annotation_view.dart';
import 'package:k_eventy/pages/home/annotations.dart';

class ARPage extends StatefulWidget {
  const ARPage({super.key});

  @override
  State<ARPage> createState() => _ARPageState();
}

class _ARPageState extends State<ARPage> {
  List<Annotation> annotations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArLocationWidget(
        annotations: annotations,
        showDebugInfoSensor: false,
        annotationViewBuilder: (context, annotation) {
          return AnnotationView(
            key: ValueKey(annotation.uid),
            annotation: annotation as Annotation,
          );
        },
        onLocationChange: (Position position) {
          Future.delayed(const Duration(seconds: 5), () {
            annotations = fakeAnnotation(position: position, numberMaxPoi: 50);
            setState(() {});
          });
        },
      ),
    );
  }
}
