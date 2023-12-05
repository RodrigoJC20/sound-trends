import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Artist {
  final String id;
  final String name;
  final int popularity;
  final String image;
  final int followers;
  final List<String> genres;

  const Artist({
    required this.id,
    required this.name,
    required this.popularity,
    required this.image,
    required this.followers,
    required this.genres,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
      popularity: json['popularity'],
      image: json['images'][0]['url'],
      followers: json['followers']['total'],
      genres: List<String>.from(json['genres']),
    );
  }
}

Future<List<Artist>> getTopArtists(String? accessToken, int n) async {
  if (accessToken == null) {
    return Future.error('Access token is null');
  }

  final url = "https://api.spotify.com/v1/me/top/artists?limit=$n";

  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    final List<dynamic> items = data['items'];

    List<Artist> artists = items.map((item) {
      return Artist.fromJson(item);
    }).toList();

    return artists;
  } else {
    throw Exception('Failed to load top artists');
  }
}

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
