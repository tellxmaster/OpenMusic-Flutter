import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/Song.dart';

class SongCardWidget extends StatelessWidget {
  final Song song;
  final NetworkImage image;

  SongCardWidget({required this.song, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: image,
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    song.artist,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
