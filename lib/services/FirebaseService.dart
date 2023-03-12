import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Song.dart';

class FirebaseService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> insertSong(Song song) async {
    await db.collection('songs').add({
      'title': song.title,
      'artist': song.artist,
      'album': song.album,
      'duration': song.duration,
      'url': song.url,
      'imageUrl': song.imageUrl,
      'prueba': song.prueba,
    });
  }

  Future<List<Song>> listSongs() async {
    List<Song> songs = [];
    QuerySnapshot querySnapshot = await db.collection('songs').get();
    for (var document in querySnapshot.docs) {
      songs.add(Song(
          title: document.get('title'),
          artist: document.get('artist'),
          album: document.get('album'),
          duration: document.get('duration'),
          url: document.get('url'),
          imageUrl: document.get('imageUrl'),
          prueba: document.get('prueba')));
    }
    return songs;
  }
}
