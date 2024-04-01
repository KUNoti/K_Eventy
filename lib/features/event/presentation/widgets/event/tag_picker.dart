import 'package:flutter/cupertino.dart';

const double _kItemExtent = 32.0;
const List<String> _tags = <String>[
  'KU',
  'Sport',
  'Festival',
  'Music',
  'Food',
];

class TagPicker extends StatefulWidget {
  final Function(String)? onTagSelected;

  const TagPicker({Key? key, this.onTagSelected}) : super(key: key);

  @override
  State<TagPicker> createState() => _TagPickerState();
}

class _TagPickerState extends State<TagPicker> {
  int _selectedTagIndex = 0;

  void _showTagPicker() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            const SizedBox(height: 6.0),
            Expanded(
              child: CupertinoPicker(
                magnification: 1.22,
                squeeze: 1.2,
                useMagnifier: true,
                itemExtent: _kItemExtent,
                scrollController: FixedExtentScrollController(
                  initialItem: _selectedTagIndex,
                ),
                onSelectedItemChanged: (int selectedItem) {
                  setState(() {
                    _selectedTagIndex = selectedItem;
                    if (widget.onTagSelected != null) {
                      widget.onTagSelected!(_tags[selectedItem]);
                    }
                  });
                },
                children: _buildTagItems(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTagItems() {
    return _tags.map((tag) => Center(child: Text(tag))).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: CupertinoColors.label.resolveFrom(context),
        fontSize: 22.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text('Tag: '),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: _showTagPicker,
            child: Text(
              _tags[_selectedTagIndex],
              style: const TextStyle(fontSize: 22.0),
            ),
          ),
        ],
      ),
    );
  }
}
