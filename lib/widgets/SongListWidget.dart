import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/Song.dart';
import './SongCardWidget.dart';

class SongListWidget extends StatelessWidget {
  final List<Song> songs;

  SongListWidget({required this.songs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Canciones Favoritas',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CarouselSlider(
          items: [
            SongCardWidget(
              song: Song(
                title: 'DÁKITI',
                artist: 'Bad Bunny',
                album: 'EL ÚLTIMO TOUR DEL MUNDO',
                duration: 3,
                url: '',
                imageUrl:
                    'https://i.scdn.co/image/ab67616d0000b273005ee342f4eef2cc6e8436ab',
              ),
              image: const NetworkImage(
                  'https://i.scdn.co/image/ab67616d0000b273005ee342f4eef2cc6e8436ab'),
            ),
            SongCardWidget(
              song: Song(
                title: 'Bzrp Musc Sessions, Vol. 50',
                artist: 'Bizarrap y Duki',
                album: 'Duki: Bzrp Musc Sessions, Vol. 50',
                duration: 2,
                url: '',
                imageUrl: '',
              ),
              image: const NetworkImage(
                  'https://cdns-images.dzcdn.net/images/cover/b5e0b5ea50caa9f63b7e7155e7fd84e1/500x500.jpg'),
            ),
            SongCardWidget(
              song: Song(
                title: 'Tití Me Preguntó',
                artist: 'Bad Bunny',
                album: 'Un Verano Sin Ti',
                duration: 4,
                url: 'none',
                imageUrl:
                    'https://cdns-images.dzcdn.net/images/cover/b29d1070377b784384c2456093f96a66/500x500.jpg',
              ),
              image: const NetworkImage(
                  'https://cdns-images.dzcdn.net/images/cover/b29d1070377b784384c2456093f96a66/500x500.jpg'),
            ),
          ],
          options: CarouselOptions(
            height: 200,
            aspectRatio: 4 / 3,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 4),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {},
            scrollDirection: Axis.horizontal,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Todas las canciones',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: songs.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(songs[index].imageUrl),
                ),
                title: Text(songs[index].title),
                subtitle: Text(songs[index].artist),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
