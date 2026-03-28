class Song {
  final String id;
  final String title;
  final String artistId;
  final String? artistName;
  final String? artistGenre;
  final Duration duration;
  final Uri imageUrl;

  Song({
    required this.id,
    required this.title,
    required this.artistId,
    this.artistName,
    this.artistGenre,
    required this.duration,
    required this.imageUrl,
  });

  Song copyWith({
    String? id,
    String? title,
    String? artistId,
    String? artistName,
    String? artistGenre,
    Duration? duration,
    Uri? imageUrl,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artistId: artistId ?? this.artistId,
      artistName: artistName ?? this.artistName,
      artistGenre: artistGenre ?? this.artistGenre,
      duration: duration ?? this.duration,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return 'Song(id: $id, title: $title, artist: $artistId, artistName: $artistName, artistGenre: $artistGenre, duration: $duration)';
  }
}
