class Song {
  int? id;
  String title;
  String artist;
  String album;
  int duration;
  String url;
  String imageUrl;

  Song(
      {this.id,
      required this.title,
      required this.artist,
      required this.album,
      required this.duration,
      required this.url,
      required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'duration': duration,
      'url': url,
      'image_url': imageUrl,
    };
  }

  @override
  String toString() {
    return 'Song{id: $id, title: $title, artista: $artist, album: $album, duration: $duration}';
  }
}
