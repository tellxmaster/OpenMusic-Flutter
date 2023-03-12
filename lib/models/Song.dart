class Song {
  int? id;
  String title;
  String artist;
  String album;
  int duration;
  String url;
  String imageUrl;
  String prueba = "Examen";

  Song(
      {this.id,
      required this.title,
      required this.artist,
      required this.album,
      required this.duration,
      required this.url,
      required this.imageUrl,
      required this.prueba});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'duration': duration,
      'url': url,
      'image_url': imageUrl,
      'prueba': prueba,
    };
  }

  @override
  String toString() {
    return 'Song{id: $id, title: $title, artista: $artist, album: $album, duration: $duration}';
  }
}
