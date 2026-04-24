  import 'package:flutter/material.dart';

  // Search widget for word lookups.
  // This widget delegates the actual lookup work to onSearch,
  // and only handles input UX and search view behavior.
  class WordSearchbar extends StatefulWidget {
    // Callback provided by parent.
    // Returns true when a search succeeds and false when it fails.
    final Future<bool> Function(String) onSearch;

    // Suggestions shown in the expanded search view.
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
    // Controls the SearchBar text and SearchAnchor open/close state.
    late final SearchController _controller;

    // Used to determine whether the bar is currently focused.
    late final FocusNode _focusNode;

    // Holds the current inline error text (null means no error).
    // We use a notifier so icon updates can happen immediately.
    late final ValueNotifier<String?> _errorTextNotifier;

    // Tracks last controller text to detect real text changes.
    String _lastControllerText = '';

    // Clears the current error if one is present.
    void _clearError() {
      if (_errorTextNotifier.value == null) return;
      _errorTextNotifier.value = null;
    }

    // Sets the current error message.
    void _setError(String message) {
      _errorTextNotifier.value = message;
    }

    // Runs on any text edit and clears stale error feedback.
    void _handleTextChanged(String value) {
      _lastControllerText = value;
      _clearError();
    }

    // Shared submit flow used by Enter, search button, and suggestion taps.
    Future<void> _submitSearch(String rawValue) async {
      // Normalize user input first.
      final value = rawValue.trim();

      // Ignore empty submissions.
      if (value.isEmpty) return;

      // Ask parent to perform the real lookup.
      final didSucceed = await widget.onSearch(value);

      // Keep typed text and show error if lookup failed.
      if (!didSucceed) {
        _setError('Word not found');
        return;
      }

      // Successful search should remove prior error state.
      _clearError();

      // Close search view if it is currently open.
      if (_controller.isOpen) {
        _controller.closeView(value);
      }

      // Clear field on successful search.
      _controller.clear();

      // Dismiss keyboard after submit.
      if (mounted) {
        FocusScope.of(context).unfocus();
      }
    }

    @override
    void initState() {
      super.initState();

      // Initialize core input state.
      _controller = SearchController();
      _focusNode = FocusNode();
      _errorTextNotifier = ValueNotifier<String?>(null);
      _lastControllerText = _controller.text;

      // Keep local UI in sync with controller text changes.
      // Also clear error when text actually changes.
      _controller.addListener(() {
        final currentText = _controller.text;
        if (currentText != _lastControllerText) {
          _clearError();
          _lastControllerText = currentText;
        }
        setState(() {});
      });

      // Rebuild when focus changes so trailing icon state updates.
      _focusNode.addListener(() {
        setState(() {});
      });

    }

    @override
    void dispose() {
      // Dispose all controllers/notifiers to avoid leaks.
      _controller.dispose();
      _focusNode.dispose();
      _errorTextNotifier.dispose();
      super.dispose();
    }

    // Button shown while typing to quickly clear current text.
    IconButton _buildClearButton(SearchController controller) {
      return IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          controller.clear();
          _clearError();
        },
      );
    }

    // Button shown when text exists but the field is not focused.
    IconButton _buildSearchButton(SearchController controller) {
      return IconButton(
        icon: const Icon(Icons.search),
        onPressed: () async {
          await _submitSearch(controller.text);
        },
      );
    }

    // Small error icon shown in trailing actions when search fails.
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

    // Reactive wrapper so error icon updates as soon as notifier changes.
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

    // Chooses trailing action based on current focus and text state.
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
    // SearchAnchor coordinates the collapsed SearchBar and the expanded view.
      return SearchAnchor(
        searchController: _controller,

      // Called when user types inside expanded search view.
        viewOnChanged: _handleTextChanged,

      // Called when Enter is pressed in expanded search view.
        viewOnSubmitted: _submitSearch,

      // Trailing actions for expanded search view.
        viewTrailing: [
          _buildReactiveErrorIcon(context),
          if (_controller.text.isNotEmpty) _buildClearButton(_controller),
        ],
        builder: (BuildContext context, SearchController controller) {
        // Collapsed search field shown in normal page layout.
          return SearchBar(
            controller: controller,
            focusNode: _focusNode,
            padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0),
            ),

          // Open suggestions view when user taps field.
            onTap: () {
              controller.openView();
            },

          // Clear error and show suggestions as text changes.
            onChanged: (value) {
              _handleTextChanged(value);
              controller.openView();
            },

          // Submit from collapsed bar Enter action.
            onSubmitted: _submitSearch,

          // Trailing actions in collapsed bar.
            trailing: [
              _buildReactiveErrorIcon(context),
              _buildTrailingButtons(controller, _focusNode),
            ],
          );
        },
        suggestionsBuilder: (BuildContext context, SearchController controller) {
        // Normalize input for case-insensitive matching.
          final query = controller.text.trim().toLowerCase();

        // Filter suggestions based on current query.
          final filteredSuggestions = widget.suggestions.where((suggestion) {
            if (query.isEmpty) return true;
            return suggestion.toLowerCase().contains(query);
          }).toList();

        // Build suggestion tiles; tapping one submits that word.
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