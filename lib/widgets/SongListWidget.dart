import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/Song.dart';
import './SongCardWidget.dart';

class SongListWidget extends StatelessWidget {
  final List<Song> songs;
  dynamic Function(Song) onSongSelected;

  SongListWidget({required this.songs, required this.onSongSelected});

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
          items: songs.map((song) {
            return SongCardWidget(
              song: song,
              image: NetworkImage(song.imageUrl),
              onTap: () => onSongSelected(song),
            );
          }).toList(),
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
                onTap: () => onSongSelected(songs[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
