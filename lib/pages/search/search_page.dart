import 'package:flutter/material.dart';
import 'package:k_eventy/components/event_card.dart';
import 'package:k_eventy/components/selectTag.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = []; // List to store search results

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SearchBar(
              controller: _searchController,
              padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)),
              onTap: () {
                // Open search view
                setState(() {
                  _searchResults.clear();
                });
              },
              onChanged: (value) {
                // Handle search logic here
                setState(() {
                  // For demonstration purposes, adding some dummy search results
                  _searchResults = List.generate(10, (index) => 'Result $index')
                      .where((result) =>
                      result.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
              leading: const Icon(Icons.search),
            ),

            // SelectTag
            Padding(
              padding: EdgeInsets.all(8),
              child: SelectTag(),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.isNotEmpty
                    ? _searchResults.length
                    : 10, // Show 10 items if no search results
                itemBuilder: (context, index) {
                  if (_searchResults.isNotEmpty) {
                    // If search results are available, display them
                    return EventCard();
                  } else {
                    // If no search results, display placeholder items
                    return EventCard();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final TextEditingController controller;
  final MaterialStateProperty<EdgeInsets>? padding;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final Widget? leading;

  const SearchBar({
    Key? key,
    required this.controller,
    this.padding,
    this.onTap,
    this.onChanged,
    this.leading,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: 'Search...',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIcon: widget.leading,
      ),
      onTap: widget.onTap,
      onChanged: widget.onChanged,
    );
  }
}
