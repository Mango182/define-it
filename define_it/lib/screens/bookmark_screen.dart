import 'package:define_it_v2/services/word_repository.dart';
import 'package:define_it_v2/services/toast_service.dart';
import 'package:flutter/material.dart';
import 'package:define_it_v2/widgets/app_drawer.dart';
import 'package:define_it_v2/database/entities/favorite_word.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkPage> {
  final WordRepository _wordRepo = WordRepository.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Favorites'),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Bookmark Items
            Expanded(
              child: FutureBuilder<List<FavoriteWord>>(
                future: _wordRepo.getAllFavoriteWords(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Failed to load favorites: ${snapshot.error}'),
                    );
                  }

                  final favorites = snapshot.data ?? const <FavoriteWord>[];
                  if (favorites.isEmpty) {
                    return const Center(child: Text('No favorites yet.'));
                  }

                  return ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final favorite = favorites[index];
                      return ListTile(
                        title: Text(favorite.word),
                        subtitle: Text(
                          favorite.definition,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () async {
                            await _wordRepo.deleteFavoriteWord(favorite.word);
                            if (!context.mounted) return;
                            ToastService.showToast(
                              'Removed "${favorite.word}" from favorites',
                            );
                            setState(() {});
                          },
                        ),
                        onTap: () {
                          ToastService.showToast(
                            'Viewing details for "${favorite.word}"',
                          );
                          // Navigate to home and show word details
                          Navigator.of(context).pushNamed('/', arguments: favorite.word)
                            .then((_) {
                              // Refresh favorites when returning
                              setState(() {});
                            });
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}