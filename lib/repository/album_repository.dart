import '../data/api_service.dart';
import '../models/album.dart';
import '../models/photo.dart';

class AlbumRepository {
  final ApiService apiService;

  AlbumRepository(this.apiService);

  Future<List<Album>> getAlbums() async {
    return await apiService.fetchAlbums();
  }

  Future<List<Photo>> getPhotos() async {
    return await apiService.fetchPhotos();
  }

  Future<Map<String, dynamic>> getAlbumsWithPhotos() async {
    final albums = await getAlbums();
    final photos = await getPhotos();
    return {'albums': albums, 'photos': photos};
  }
}