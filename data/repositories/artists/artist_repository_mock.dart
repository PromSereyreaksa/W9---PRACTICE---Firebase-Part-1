import '../../../model/artists/artist.dart';
import 'artist_repository.dart';

class ArtistRepositoryMock implements ArtistRepository {
  final List<Artist> _artists = [];

  @override
  Future<List<Artist>> fetchArtists() async {
    return Future.delayed(Duration(seconds: 1), () {
      return _artists;
    });
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {
    return Future.delayed(Duration(seconds: 1), () {
      for (Artist artist in _artists) {
        if (artist.id == id) {
          return artist;
        }
      }

      throw Exception('No artist with id $id in the database');
    });
  }
}
