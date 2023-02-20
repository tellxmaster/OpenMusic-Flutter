import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Song.dart';

class FirebaseService {
  late FirebaseFirestore _firestore;

  Future<void> initDatabase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _firestore = FirebaseFirestore.instance;
  }

  Future<void> insertSong(Song song) async {
    await _firestore.collection('songs').add({
      'title': song.title,
      'artist': song.artist,
      'album': song.album,
      'duration': song.duration,
      'url': song.url,
      'imageUrl': song.imageUrl,
    });
  }

  Future<List<Song>> listSongs() async {
    List<Song> songs = [];
    QuerySnapshot querySnapshot = await _firestore.collection('songs').get();
    for (var document in querySnapshot.docs) {
      songs.add(Song(
          title: document.get('title'),
          artist: document.get('artist'),
          album: document.get('album'),
          duration: document.get('duration'),
          url: document.get('url'),
          imageUrl: document.get('imgUrl')));
    }
    return songs;
  }
}
