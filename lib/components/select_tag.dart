import 'package:flutter/material.dart';

enum Tag { music, sport, KU, art, festival }

class SelectTag extends StatefulWidget {
  const SelectTag({Key? key});

  @override
  State<SelectTag> createState() => _SelectTagState();
}

class _SelectTagState extends State<SelectTag> {
  Tag? tagView;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Tag>(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.blue; // Change to whatever color you want
          }
          return Colors.white; // Default color
        }),
        elevation: MaterialStateProperty.all(3),
      ),
      emptySelectionAllowed: true,
      segments: const <ButtonSegment<Tag>>[
        ButtonSegment<Tag>(
            value: Tag.KU,
            label: Text('KU', style: TextStyle(fontSize: 8)),
            icon: Icon(Icons.school)),
        ButtonSegment<Tag>(
            value: Tag.festival,
            label: Text('Festival', style: TextStyle(fontSize: 8)),
            icon: Icon(Icons.festival)),
        ButtonSegment<Tag>(
            value: Tag.music,
            label: Text('Music', style: TextStyle(fontSize: 8)),
            icon: Icon(Icons.music_note)),
        ButtonSegment<Tag>(
            value: Tag.sport,
            label: Text('Sport', style: TextStyle(fontSize: 8)),
            icon: Icon(Icons.sports_bar_outlined)),
      ],
      selected: tagView != null ? <Tag>{tagView!} : <Tag>{},
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
