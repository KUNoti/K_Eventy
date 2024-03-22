import 'package:flutter/material.dart';
import 'package:k_eventy/features/event/presentation/widgets/common/select_tag.dart';
import 'package:k_eventy/features/event/presentation/widgets/event/event_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = []; // List to store search results

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SearchBar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SearchBar(
              controller: _searchController,
              onTap: () {
                // Open search view
                setState(() {
                  _searchResults.clear();
                });
              },
              onChanged: (value) {
                // Handle search logic here
                setState(() {
                  _searchResults = List.generate(
                      10, (index) => 'Result $index')
                      .where((result) =>
                      result.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
              leading: const Icon(Icons.search),
            ),
          ),

          // SelectTag
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.all(8),
            child: SelectTag(),
          ),

          // Search Results
          _buildListEvent(context),
        ],
      ),
    );
  }

  Widget _buildListEvent(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _searchResults.isNotEmpty
            ? _searchResults.length
            : 10,
        itemBuilder: (context, index) {
          if (_searchResults.isNotEmpty) {
            return const Padding(
              padding:  EdgeInsets.symmetric(vertical: 8.0),
              child: EventCard(),
            );
          } else {
            return const Padding(
              padding:  EdgeInsets.symmetric(vertical: 8.0),
              child: EventCard(),
            );
          }
        },
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final Widget? leading;

  const SearchBar({
    Key? key,
    required this.controller,
    this.onTap,
    this.onChanged,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search...',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIcon: leading,
      ),
      onTap: onTap,
      onChanged: onChanged,
    );
  }
}
