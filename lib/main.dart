import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_firebase/services/FirebaseService.dart';
import 'package:test_firebase/widgets/FormSong.dart';
import 'package:test_firebase/widgets/ListSongs.dart';
import 'package:test_firebase/widgets/SongListWidget.dart';
import 'firebase_options.dart';
import 'models/Song.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenMusic App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightGreen,
        canvasColor: Colors.grey[900],
        scaffoldBackgroundColor: Colors.grey[900],
        cardColor: Colors.grey[800],
        dividerColor: Colors.grey[700],
        focusColor: Colors.purple[300],
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
  final FirebaseService _firebaseService = FirebaseService();
  List<Song> _songs = [];

  @override
  void initState() {
    super.initState();
    _fetchSongs();
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

  Future<void> _fetchSongs() async {
    List<Song> songs = await _firebaseService.listSongs();
    setState(() {
      _songs = songs;
    });
  }

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
      _fetchSongs();
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
                  padding: const EdgeInsets.all(8),
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
    List<Widget> content = <Widget>[
      SongListWidget(
        songs: _songs,
        onSongSelected: (song) => _playSong(song),
      ),
      SongForm(),
      const ListSongs()
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
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
// Handle search button press
              },
            ),
          ]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(
                'OpenMusic',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                ),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              leading: const Icon(Icons.key),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: content[_itemSeleccionado],
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
