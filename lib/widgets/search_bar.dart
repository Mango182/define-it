  import 'package:define_it_v2/models/word_result.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/widget_previews.dart';
  import 'package:define_it_v2/services/dictionary_api.dart';

  class WordSearchbar extends StatefulWidget {
    const WordSearchbar({super.key});

    @override
    State<WordSearchbar> createState() => _WordSearchbarState();
  }

  class _WordSearchbarState extends State<WordSearchbar> {
    late final SearchController _controller;
    late final FocusNode _focusNode;

    @override
    void initState() {
      super.initState();
      _controller = SearchController();
      _focusNode = FocusNode();

      _controller.addListener(() {
        setState(() {});
      });

      _focusNode.addListener(() {
        setState(() {});
      });

    }

    @override
    void dispose() {
      _controller.dispose();
      _focusNode.dispose();
      super.dispose();
    }

    void _performSearch(String value) async {
      if (value.isEmpty) return;
      if (_controller.isOpen) {
        _controller.closeView(value);
      }
      FocusScope.of(context).unfocus();
      final messanger = ScaffoldMessenger.of(context);
      try {
        final WordResult wordResult = WordResult.fromJson(await DictionaryAPI().fetchDefinition(value));
        if (!mounted) return;
        messanger.showSnackBar(
          SnackBar(content: Text(wordResult.toString()))
        );
      } catch (e) {
        if (!mounted) return;
        messanger.showSnackBar(
          SnackBar(content: Text('Error fetching definition: $e'))
        );
      }
    }

    IconButton _buildClearButton(SearchController controller) {
      return IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          controller.clear();
        },
      );
    }

    IconButton _buildSearchButton(SearchController controller) {
      return IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          _performSearch(controller.text);
        },
      );
    }

    Widget _buildTrailingButtons(SearchController controller, FocusNode focusNode) {
      final bool isFocused = focusNode.hasFocus;
      final bool hasText = controller.text.isNotEmpty;

      // if typing, show clear button
      if (hasText && isFocused) {
        return _buildClearButton(controller);
      } 

      // if not typing but has text, show search button
      if (hasText && !isFocused) {
        return _buildSearchButton(controller);
      }

      // if no text, show nothing
      return const SizedBox.shrink();
    }

    @override
    Widget build(BuildContext context) {
      return SearchAnchor(
        searchController: _controller,
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            focusNode: _focusNode,
            padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0),
            ),
            onTap: () => controller.openView(),
            onChanged: (_) => controller.openView(),
            onSubmitted: null,
            trailing: [ _buildTrailingButtons(controller, _focusNode)],
          );
        },
        suggestionsBuilder:
          (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = "Suggestion $index";
              return ListTile(
                title: Text(item),
                onTap: () {
                  // Implement suggestion selection functionality here
                  controller.closeView(item);
                },
              );
            });
          },
      );
    }
  }

@Preview(name: "Preview Word Searchbar")
Widget previewWordSearchbar() {
  return const MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            WordSearchbar(),
          ],
        ),
      ),
    ),
  );
}