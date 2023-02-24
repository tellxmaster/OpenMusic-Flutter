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
    List<String> parts;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Titulo',
                    filled: true,
                    suffixIcon: Icon(Icons.title),
                    fillColor: Colors.grey[850],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.purple[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.purple[300]!),
                    ),
                    iconColor: Colors.purple[300]!),
                validator: (value) =>
                    value!.isEmpty ? 'El titulo no puede estar vacio' : null,
                onSaved: (value) => _song.title = value!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Artista',
                    filled: true,
                    suffixIcon: Icon(Icons.people),
                    fillColor: Colors.grey[850],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.purple[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.purple[300]!),
                    ),
                    iconColor: Colors.purple[300]!),
                validator: (value) =>
                    value!.isEmpty ? 'El artista no puede estar vacio' : null,
                onSaved: (value) => _song.artist = value!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Album',
                    filled: true,
                    suffixIcon: Icon(Icons.album),
                    fillColor: Colors.grey[850],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.purple[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.purple[300]!),
                    ),
                    iconColor: Colors.purple[300]!),
                validator: (value) =>
                    value!.isEmpty ? 'El album no puede estar vacio' : null,
                onSaved: (value) => _song.album = value!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Duración',
                    filled: true,
                    suffixIcon: Icon(Icons.timer),
                    fillColor: Colors.grey[850],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.purple[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.purple[300]!),
                    ),
                    iconColor: Colors.purple[300]!),
                keyboardType: TextInputType.datetime,
                validator: (value) =>
                    value!.isEmpty ? 'La Duracion no puede ser vacia' : null,
                onSaved: (value) => _song.duration = int.tryParse(value!)!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Audio URL',
                    filled: true,
                    suffixIcon: Icon(Icons.link),
                    fillColor: Colors.grey[850],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.purple[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.purple[300]!),
                    ),
                    iconColor: Colors.purple[300]!),
                validator: (value) => value!.isEmpty
                    ? 'La URL del audio no puede estar vacia'
                    : null,
                onSaved: (value) => _song.url = value!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Imagen URL',
                    filled: true,
                    suffixIcon: Icon(Icons.image),
                    fillColor: Colors.grey[850],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.purple[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.purple[300]!),
                    ),
                    iconColor: Colors.purple[300]!),
                validator: (value) => value!.isEmpty
                    ? 'La URL de la imagen no puede estar vacio'
                    : null,
                onSaved: (value) => _song.imageUrl = value!,
              ),
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
