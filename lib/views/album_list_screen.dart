
import 'package:album_app/viewmodels/bloc/album_bloc.dart';
import 'package:album_app/viewmodels/bloc/album_event.dart';
import 'package:album_app/viewmodels/bloc/album_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../models/photo.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Albums")),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AlbumErrorState) {
            return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
          }

          if (state is AlbumLoadedState) {
            final albums = state.albums;
            final photos = state.photos;

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: albums.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final album = albums[index];
                final photo = photos.firstWhere(
                  (p) => p.albumId == album.id,
                  orElse: () => Photo(albumId: 0, title: '', thumbnailUrl: ''),
                );

                return GestureDetector(
                  onTap: () => context.go('/detail/${album.id}'),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          photo.thumbnailUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const SizedBox(
                              width: 50,
                              height: 50,
                              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                            );
                          },
                        ),
                      ),
                      title: Text(
                        album.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text("Tap refresh to load albums."));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.read<AlbumBloc>().add(FetchAlbumsEvent()),
        icon: const Icon(Icons.refresh),
        label: const Text("Refresh"),
      ),
    );
  }
}