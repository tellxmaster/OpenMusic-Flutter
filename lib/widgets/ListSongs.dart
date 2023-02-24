import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/Song.dart';
import '../services/FirebaseService.dart';

class ListSongs extends StatefulWidget {
  const ListSongs({super.key});

  @override
  State<ListSongs> createState() => _ListSongsState();
}

class _ListSongsState extends State<ListSongs> {
  List<Song> _songs = [];
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    _listSongs();
  }

  Future<void> _listSongs() async {
    // Call the service method here to get the list of songs
    List<Song> result = await _firebaseService.listSongs();
    setState(() {
      _songs = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _songs.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(Icons.audiotrack),
          title: Text(_songs[index].title),
          subtitle: Text(_songs[index].artist + " - " + _songs[index].album),
          trailing: Icon(Icons.more_vert),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Reproduciendo...'),
              ),
            );
          },
        );
      },
    );
  }
}
