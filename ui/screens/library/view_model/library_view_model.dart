import 'package:flutter/material.dart';
import '../../../../data/repositories/artists/artist_repository.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/artists/artist.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final ArtistRepository artistRepository;
  final SongRepository songRepository;
  final PlayerState playerState;

  AsyncValue<List<Song>> songsValue = AsyncValue.loading();

  LibraryViewModel({
    required this.artistRepository,
    required this.songRepository,
    required this.playerState,
  }) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<Song> songs = await songRepository.fetchSongs();
      List<Song> joinedSongs = await _joinSongsWithArtists(songs);
      songsValue = AsyncValue.success(joinedSongs);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }
    notifyListeners();

  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();

  Future<List<Song>> _joinSongsWithArtists(List<Song> songs) async {
    List<Artist> artists = await artistRepository.fetchArtists();
    Map<String, Artist?> artistsById = {};

    for (Artist artist in artists) {
      artistsById[artist.id] = artist;
    }

    return songs.map((song) {
      Artist? artist = artistsById[song.artistId];

      return song.copyWith(
        artistName: artist?.name,
        artistGenre: artist?.genre,
      );
    }).toList();
  }
}
