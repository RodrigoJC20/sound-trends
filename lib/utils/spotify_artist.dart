import 'package:flutter/material.dart';

// class Artist {
//   final String id;
//   final String name;
//   final int popularity;
//   final String image;
//   final int followers;
//   final List<String> genres;
//
//   const Artist({
//     required this.id,
//     required this.name,
//     required this.popularity,
//     required this.image,
//     required this.followers,
//     required this.genres,
//   });
//
//   factory Artist.fromJson(Map<String, dynamic> json) {
//     return switch (json) {
//       {
//       'id': String id,
//       'name': String name,
//       'popularity': int popularity,
//       'image': String image,
//       'followers': int followers,
//       'genres': List<String> genres
//       } => Artist(
//           id: id,
//           name: name,
//           popularity: popularity,
//           image: image,
//           followers: followers,
//           genres: genres
//       ),
//       _ => throw const FormatException('Failed to load the artist'),
//     };
//   }
// }

class SpotifyArtistCard extends StatelessWidget {
  final String artistName;
  final String imageUrl;

  const SpotifyArtistCard({
    Key? key,
    required this.artistName,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90.0,
          height: 90.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Flexible(
          child: Text(
            artistName,
            style: const TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
