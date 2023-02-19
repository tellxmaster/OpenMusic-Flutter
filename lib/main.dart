import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_firebase/services/FirebaseService.dart';
import 'package:test_firebase/widgets/SongListWidget.dart';
import 'firebase_options.dart';
import 'models/Song.dart';

Future<void> main() async {
  FireBaseService fireBaseService = FireBaseService();
  await fireBaseService.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightGreen,
        canvasColor: Colors.grey[900],
        scaffoldBackgroundColor: Colors.grey[900],
        cardColor: Colors.grey[800],
        dividerColor: Colors.grey[700],
        focusColor: Colors.greenAccent,
        hoverColor: Colors.greenAccent.withOpacity(0.2),
        splashColor: Colors.greenAccent.withOpacity(0.4),
        textTheme: const TextTheme(
            headlineLarge: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: TextStyle(
              color: Colors.white,
              fontSize: 16,
            )),
      ),
      home: const MyHomePage(title: 'OpenMusic'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _itemSeleccionado = 0;
  static final List<Song> songs = [
    Song(
        title: 'Good News',
        artist: 'Mac Miller',
        album: 'Circles',
        duration: 5,
        url: 'none',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/en/1/15/Mac_Miller_-_Circles.png'),
    Song(
        title: 'Complicated',
        artist: 'Mac Miller',
        album: 'Circles',
        duration: 3,
        url: 'none',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/en/1/15/Mac_Miller_-_Circles.png')
  ];

  final List<Widget> _content = <Widget>[SongListWidget(songs: songs)];

  void _onItemTarget(int index) {
    //ONcLICK MENU
    setState(() {
      _itemSeleccionado = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: const TextSpan(
                  text: 'Open',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Music',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 21.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.play_circle_fill),
            ],
          ),
          backgroundColor: Colors.purple,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Handle menu button press
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Handle search button press
              },
            ),
          ]),
      body: Center(
        //child: _opcionesPantalla.elementAt(_itemSeleccionado),
        child: _content.elementAt(_itemSeleccionado),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.my_library_add), label: 'Agregar Canciones'),
          BottomNavigationBarItem(
              icon: Icon(Icons.my_library_music), label: 'Listado Canciones'),
        ],
        currentIndex: _itemSeleccionado,
        selectedItemColor: Colors.purple,
        onTap: _onItemTarget,
      ),
    );
  }
}
