import 'package:flutter/material.dart';

enum Tag { music, sport, KU, art, festival }

class SelectTag extends StatefulWidget {
  const SelectTag ({Key? key});

  @override
  State<SelectTag> createState() => _SelectTagState();
}

class _SelectTagState extends State<SelectTag> {
  Tag tagView = Tag.music;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Tag>(
      segments: const <ButtonSegment<Tag>>[
        ButtonSegment<Tag>(
            value: Tag.KU,
            label: Text('KU', style: TextStyle(fontSize: 8)),
            icon: Icon(Icons.calendar_view_day)),
        ButtonSegment<Tag>(
            value: Tag.festival,
            label: Text('Festival', style: TextStyle(fontSize: 8)),
            icon: Icon(Icons.calendar_view_week)),
        ButtonSegment<Tag>(
            value: Tag.music,
            label: Text('Music', style: TextStyle(fontSize: 8)),
            icon: Icon(Icons.calendar_view_month)),
        ButtonSegment<Tag>(
            value: Tag.sport,
            label: Text('Sport', style: TextStyle(fontSize: 8)),
            icon: Icon(Icons.calendar_today)),
      ],
      selected: <Tag>{tagView},
      onSelectionChanged: (Set<Tag> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          tagView = newSelection.first;
        });
      },
    );
  }
}
