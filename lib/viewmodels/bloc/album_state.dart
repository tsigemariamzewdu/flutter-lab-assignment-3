import 'package:album_app/models/album.dart';
import 'package:album_app/models/photo.dart';

abstract class AlbumState {}

class AlbumInitialState extends AlbumState {}

class AlbumLoadingState extends AlbumState {}

class AlbumLoadedState extends AlbumState {
  final List<Album> albums;
  final List<Photo> photos;
  
  AlbumLoadedState(this.albums, this.photos);
}

class AlbumErrorState extends AlbumState {
  final String message;
  
  AlbumErrorState(this.message);
}