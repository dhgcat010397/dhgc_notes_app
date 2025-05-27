import 'dart:async';

import 'package:flutter/material.dart';

class NoteAppSearchBar extends StatefulWidget {
  const NoteAppSearchBar({super.key, required this.onSearch});

  final Function(String query)? onSearch;

  @override
  State<NoteAppSearchBar> createState() => _NoteAppSearchBarState();
}

class _NoteAppSearchBarState extends State<NoteAppSearchBar> {
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;
  Timer? _debounce;
  final int _debounceDuration = 1500; // milliseconds
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _debounce?.cancel();

    _searchController.dispose();
    _searchFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Search Notes by title',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        // Handle search logic
        _onSearchChanged(value);
      },
    );
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(Duration(milliseconds: _debounceDuration), () {
      if (query.toLowerCase() == _searchQuery.toLowerCase()) {
        debugPrint('No change in search query: "$query"');
        return; // No change in query, do nothing
      } else {
        _searchQuery = query;
        widget.onSearch?.call(_searchQuery);
      }
    });
  }
}
