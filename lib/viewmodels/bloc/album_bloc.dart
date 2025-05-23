import 'package:album_app/models/album.dart';
import 'package:album_app/models/photo.dart';
import 'package:album_app/repository/album_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'album_event.dart';
import 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository repository;

  AlbumBloc(this.repository) : super(AlbumInitialState()) {
    on<FetchAlbumsEvent>(_onFetchAlbums);
  }

  Future<void> _onFetchAlbums(
    FetchAlbumsEvent event,
    Emitter<AlbumState> emit,
  ) async {
    try {
      emit(AlbumLoadingState());
      final data = await repository.getAlbumsWithPhotos();
      emit(AlbumLoadedState(data['albums'] as List<Album>, data['photos'] as List<Photo>));
    } catch (e) {
      emit(AlbumErrorState(e.toString()));
    }
  }
}