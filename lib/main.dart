import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_firebase/services/FirebaseService.dart';
import 'package:test_firebase/widgets/FormSong.dart';
import 'package:test_firebase/widgets/SongListWidget.dart';
import 'firebase_options.dart';
import 'models/Song.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  FirebaseService fireBaseService = FirebaseService();
  await fireBaseService.initDatabase();
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
  late Song _currentSong = Song(
    title: '',
    artist: '',
    album: '',
    duration: 0,
    url: '',
    imageUrl: '',
  );
  final _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    _audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  static final List<Song> songs = [
    Song(
        title: 'Good News',
        artist: 'Mac Miller',
        album: 'Circles',
        duration: 5,
        url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/en/1/15/Mac_Miller_-_Circles.png'),
    Song(
        title: 'Song 2',
        artist: 'SoundHelix',
        album: 'Test',
        duration: 3,
        url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
        imageUrl:
            'https://cdn.domestika.org/c_fit,dpr_auto,f_auto,t_base_params,w_820/v1589500982/content-items/004/567/801/13th_Floor_Elevators_Psychedelic-original.jpg?1589500982'),
    Song(
        title: 'Complicated',
        artist: 'Mac Miller',
        album: 'Circles',
        duration: 3,
        url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/en/1/15/Mac_Miller_-_Circles.png'),
    Song(
        title: 'Imigrant Song',
        artist: 'Led Zeppelin',
        album: 'Led Zeppelin III',
        duration: 3,
        url:
            'http://188.165.227.112/portail/musique/Led%20Zeppelin%20-%20Discography/Led%20Zeppelin%20-%20Led%20Zeppelin%20III/Led%20Zeppelin%20-%20Led%20Zeppelin%20III%20-%2001%20-%20Immigrant%20Song.mp3',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/en/5/5f/Led_Zeppelin_-_Led_Zeppelin_III.png')
  ];

  void _playSong(Song song) async {
    setState(() {
      _currentSong = song;
    });
    if (_isPlaying) {
      _isPlaying = false;
      await _audioPlayer.pause();
    } else {
      _isPlaying = true;
      await _audioPlayer.play(song.url);
    }
  }

  void _onItemTarget(int index) {
    setState(() {
      _itemSeleccionado = index;
    });
  }

  void _pauseSong() {
    setState(() {
      _isPlaying = false;
      _audioPlayer.pause();
    });
  }

  void _resumeSong() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  void _stopSong() {
    setState(() {
      _isPlaying = false;
      _audioPlayer.stop();
    });
  }

  Widget _buildAudioPlayer() {
    return Container(
      height: 70,
      width: double.infinity,
      color: Colors.grey[800],
      child: Stack(
        children: [
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage(_currentSong.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  padding: EdgeInsets.all(8),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentSong.title,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          _currentSong.artist,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: IconButton(
                    icon: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (_isPlaying) {
                        _pauseSong();
                      } else if (!_isPlaying) {
                        _playSong(_currentSong);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(
              value: (position.inSeconds.toDouble()) / 200,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple[300]!),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _content = <Widget>[
      SongListWidget(
        songs: songs,
        onSongSelected: (song) => _playSong(song),
      ),
      SongForm()
    ];
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
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _content[_itemSeleccionado],
          ),
          _buildAudioPlayer(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Principal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_add),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_music),
            label: 'Biblioteca',
          ),
        ],
        currentIndex: _itemSeleccionado,
        selectedItemColor: Colors.purple,
        onTap: _onItemTarget,
      ),
    );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }
}
