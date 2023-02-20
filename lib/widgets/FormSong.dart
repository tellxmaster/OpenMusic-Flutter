import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../models/Song.dart';
import '../services/FirebaseService.dart';

class SongForm extends StatefulWidget {
  @override
  _SongFormState createState() => _SongFormState();
}

class _SongFormState extends State<SongForm> {
  final _formKey = GlobalKey<FormState>();
  FirebaseService fbService = FirebaseService();
  final Song _song = Song(
      title: '', artist: '', album: '', duration: 0, url: '', imageUrl: '');

  void _submit(Song sng) async {
    developer.log(_formKey.currentState!.validate().toString());
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      //sng.id = 1;
      try {
        developer.log(sng.toString());
        fbService.insertSong(sng);
        developer.log('Song inserted successfully!');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Canción Ingresada Correctamente'),
          ),
        );
        _formKey.currentState?.reset();
      } catch (e) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Error'),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Titulo', prefixIcon: Icon(Icons.title)),
              validator: (value) =>
                  value!.isEmpty ? 'El titulo no puede estar vacio' : null,
              onSaved: (value) => _song.title = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Artista', prefixIcon: Icon(Icons.person)),
              validator: (value) =>
                  value!.isEmpty ? 'El Artista no puede estar vacio' : null,
              onSaved: (value) => _song.artist = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Album', prefixIcon: Icon(Icons.album)),
              validator: (value) =>
                  value!.isEmpty ? 'El Album no puede estar vacio' : null,
              onSaved: (value) => _song.album = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Duracion', prefixIcon: Icon(Icons.timer)),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value!.isEmpty ? 'La Duracion no puede ser vacia' : null,
              onSaved: (value) => _song.duration = int.tryParse(value!)!,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'URL', prefixIcon: Icon(Icons.link)),
              validator: (value) =>
                  value!.isEmpty ? 'URL no puede estar vacia' : null,
              onSaved: (value) => _song.url = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Image URL', prefixIcon: Icon(Icons.image)),
              validator: (value) =>
                  value!.isEmpty ? 'Image URL no puede estar vacia' : null,
              onSaved: (value) => _song.imageUrl = value!,
            ),
            Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  child: const Text('Guardar'),
                  onPressed: () {
                    _submit(_song);
                    developer.log(_song.toString());
                  },
                ))
          ],
        ),
      ),
    );
  }
}
