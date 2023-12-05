import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Track {
  final String id;
  final String name;
  final String image;
  final List<String> artists;

  const Track({
    required this.id,
    required this.name,
    required this.image,
    required this.artists,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['id'],
      name: json['name'],
      image: json['album']['images'][0]['url'],
      artists: (json['artists'] as List<dynamic>)
          .map((artist) => artist['name'].toString())
          .toList(),
    );
  }
}

Future<List<Track>> getRecentlyPlayed(String? accessToken) async {
  if (accessToken == null) {
    return Future.error('Access token is null');
  }

  const url = "https://api.spotify.com/v1/me/player/recently-played?limit=15";

  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    final List<dynamic> items = data['items'];

    List<Track> recentTracks = items.map((item) {
      return Track(
        id: item['track']['id'] ?? '',
        name: item['track']['name'] ?? '',
        image: item['track']['album']['images'][0]['url'] ?? '',
        artists: (item['track']['artists'] as List<dynamic>)
            .map((artist) => artist['name'].toString())
            .toList(),
      );
    }).toList();

    return recentTracks;
  } else {
    throw Exception('Failed to load top tracks');
  }
}

Future<List<Track>> getTopTracks(String? accessToken) async {
  if (accessToken == null) {
    return Future.error('Access token is null');
  }

  const url = "https://api.spotify.com/v1/me/top/tracks?limit=5";

  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    final List<dynamic> items = data['items'];

    List<Track> tracks = items.map((item) {
      return Track.fromJson(item);
    }).toList();

    return tracks;
  } else {
    throw Exception('Failed to load top tracks');
  }
}

class SpotifyTrackCard extends StatelessWidget {
  final String songName;
  final List<String> authors;
  final String imageUrl;

  const SpotifyTrackCard({
    Key? key,
    required this.songName,
    required this.authors,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFF1E1E1E),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E1E1E),
            Color(0xFF333333),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.network(
            imageUrl,
            width: 50.0,
            height: 50.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  songName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  authors.join(", "),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}