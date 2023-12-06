import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_trends/views/stats.dart';

import '../spotify_api/artist.dart';
import '../spotify_api/auth.dart';
import '../spotify_api/track.dart';
import '../utils/providers.dart';
import 'home.dart';

class Recommendations extends StatefulWidget {
  const Recommendations({super.key});

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  List<Artist> topArtists = [];
  List<Track> topTracks = [];
  List<Track> recommendations = [];

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final Authentication? userAuth = authProvider.userAuth;

    if (userAuth != null && !isTokenValid(userAuth.requestedAt, userAuth.expiresIn)) {
      refreshNewToken(userAuth.refreshToken).then((auth) {
        authProvider.setAuth(auth);
      });
    }

    getTopArtists(userAuth?.accessToken, 5).then((artists) {
      setState(() {
        topArtists = artists;
      });
      getTopTracks(userAuth?.accessToken, 5).then((tracks) {
        setState(() {
          topTracks = tracks;
        });
        String artistsString = '${topArtists[0].id},${topArtists[1].id}';
        String tracksString = '${topTracks[0].id},${topTracks[1].id}';
        String genresString = topArtists[0].genres[0];

        getRecommendations(userAuth?.accessToken, artistsString, tracksString, genresString).then((recomm) {
          setState(() {
            recommendations = recomm;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int selectedTab = 2;

    return Scaffold(
      backgroundColor: const Color.fromARGB(232, 0, 0, 0),
      body: SingleChildScrollView(
        child: SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 45.0, left: 15.0, right: 10.0, bottom: 15.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: const [
                        TextSpan(
                          text: 'Look at your   ',
                          style: TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        TextSpan(
                          text: 'Recommendations',
                          style: TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1EF133),
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tracks",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      for (var track in recommendations)
                        Column(
                          children: [
                            SpotifyTrackCard(
                              songName: track.name,
                              authors: track.artists,
                              imageUrl: track.image,
                            ),
                            const SizedBox(height: 8.0),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(232, 0, 0, 0),
        selectedItemColor: const Color(0xFF1EF133),
        unselectedItemColor: const Color.fromARGB(165, 241, 239, 239),

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Discover',
          ),
        ],
        currentIndex: selectedTab,
        onTap: (int index) {
          setState(() {
            selectedTab = index;
            if(selectedTab == 1){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const UserStats()));
            } else if(selectedTab == 0){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
            }
          });
        },
      ),
    );
  }
}
