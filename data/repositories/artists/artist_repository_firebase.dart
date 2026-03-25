import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/artists/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase extends ArtistRepository {
  final Uri artistsUri = Uri.https(
    'week-8-practice-78755-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/artists.json',
  );

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> artistJson = Map<String, dynamic>.from(
        json.decode(response.body),
      );
      List<Artist> result = [];

      for (var iterable in artistJson.entries) {
        String artistId = iterable.key;
        Map<String, dynamic> values = Map<String, dynamic>.from(iterable.value);
        result.add(ArtistDto.fromJson(artistId, values));
      }
      return result;
    } else {
      throw Exception('Failed to load artists');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {
    final Uri artistUri = Uri.https(
      '[redacted].firebasedatabase.app',
      '/artists/$id.json',
    );
    final http.Response response = await http.get(artistUri);

    if (response.statusCode == 200) {
      if (response.body == 'null') {
        return null;
      }

      final Map<String, dynamic> values = Map<String, dynamic>.from(
        json.decode(response.body),
      );
      return ArtistDto.fromJson(id, values);
    } else {
      throw Exception('Failed to load artist');
    }
  }
}
