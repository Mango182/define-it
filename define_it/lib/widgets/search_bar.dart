  import 'package:flutter/material.dart';

  class WordSearchbar extends StatefulWidget {
    final Future<bool> Function(String) onSearch;
    final List<String> suggestions;
    const WordSearchbar({
      super.key,
      required this.onSearch,
      this.suggestions = const [],
    });

    @override
    State<WordSearchbar> createState() => _WordSearchbarState();
  }

  class _WordSearchbarState extends State<WordSearchbar> {
    late final SearchController _controller;
    late final FocusNode _focusNode;
    late final ValueNotifier<String?> _errorTextNotifier;
    String _lastControllerText = '';

    void _clearError() {
      if (_errorTextNotifier.value == null) return;
      _errorTextNotifier.value = null;
    }

    void _setError(String message) {
      _errorTextNotifier.value = message;
    }

    void _handleTextChanged(String value) {
      _lastControllerText = value;
      _clearError();
    }

    Future<void> _submitSearch(String rawValue) async {
      final value = rawValue.trim();
      if (value.isEmpty) return;

      final didSucceed = await widget.onSearch(value);

      if (!didSucceed) {
        _setError('Word not found');
        return;
      }

      _clearError();

      if (_controller.isOpen) {
        _controller.closeView(value);
      }

      _controller.clear();

      if (mounted) {
        FocusScope.of(context).unfocus();
      }
    }

    @override
    void initState() {
      super.initState();
      _controller = SearchController();
      _focusNode = FocusNode();
      _errorTextNotifier = ValueNotifier<String?>(null);
      _lastControllerText = _controller.text;

      _controller.addListener(() {
        final currentText = _controller.text;
        if (currentText != _lastControllerText) {
          _clearError();
          _lastControllerText = currentText;
        }
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
      _errorTextNotifier.dispose();
      super.dispose();
    }

    IconButton _buildClearButton(SearchController controller) {
      return IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          controller.clear();
          _clearError();
        },
      );
    }

    IconButton _buildSearchButton(SearchController controller) {
      return IconButton(
        icon: const Icon(Icons.search),
        onPressed: () async {
          await _submitSearch(controller.text);
        },
      );
    }

    Widget _buildErrorIcon(BuildContext context, String message) {
      return Tooltip(
        message: message,
        child: Icon(
          Icons.error_outline,
          color: Theme.of(context).colorScheme.error,
          size: 20,
        ),
      );
    }

    Widget _buildReactiveErrorIcon(BuildContext context) {
      return ValueListenableBuilder<String?>(
        valueListenable: _errorTextNotifier,
        builder: (context, errorText, _) {
          if (errorText == null) {
            return const SizedBox.shrink();
          }
          return _buildErrorIcon(context, errorText);
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
        viewOnChanged: _handleTextChanged,
        viewOnSubmitted: _submitSearch,
        viewTrailing: [
          _buildReactiveErrorIcon(context),
          if (_controller.text.isNotEmpty) _buildClearButton(_controller),
        ],
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            focusNode: _focusNode,
            padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0),
            ),
            onTap: () {
              controller.openView();
            },
            onChanged: (value) {
              _handleTextChanged(value);
              controller.openView();
            },
            onSubmitted: _submitSearch,
            trailing: [
              _buildReactiveErrorIcon(context),
              _buildTrailingButtons(controller, _focusNode),
            ],
          );
        },
        suggestionsBuilder: (BuildContext context, SearchController controller) {
          final query = controller.text.trim().toLowerCase();
          final filteredSuggestions = widget.suggestions.where((suggestion) {
            if (query.isEmpty) return true;
            return suggestion.toLowerCase().contains(query);
          }).toList();

          return filteredSuggestions.map((item) {
            return ListTile(
              title: Text(item),
              onTap: () async {
                await _submitSearch(item);
              },
            );
          });
        },
      );
    }
  }