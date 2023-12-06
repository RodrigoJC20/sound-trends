import 'dart:convert';
import 'package:http/http.dart' as http;

class Genre {
  final String name;
  final double popularity;

  const Genre({
    required this.name,
    required this.popularity
  });
}

class Stats {
  final double danceable;
  final double energy;
  final List<Genre>? topGenres;

  const Stats({
    required this.danceable,
    required this.energy,
    this.topGenres,
  });
}


Future<Stats> getStats(String? accessToken, String tracks) async {
  if (accessToken == null) {
    return Future.error('Access token is null');
  }

  final url = "https://api.spotify.com/v1/audio-features?ids=$tracks";

  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    List<dynamic> audioFeaturesList = jsonResponse['audio_features'];

    double totalDanceability = 0.0;
    double totalEnergy = 0.0;

    for (var feature in audioFeaturesList) {
      totalDanceability += feature['danceability'];
      totalEnergy += feature['energy'];
    }

    double averageDanceability = totalDanceability / audioFeaturesList.length;
    double averageEnergy = totalEnergy / audioFeaturesList.length;

    return Stats(
      danceable: averageDanceability,
      energy: averageEnergy,
    );
  } else {
    throw Exception('Failed to load audio features');
  }
}