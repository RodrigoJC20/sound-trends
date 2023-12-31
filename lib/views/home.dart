import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_trends/spotify_api/auth.dart';
import 'package:sound_trends/views/discover.dart';
import 'package:sound_trends/views/stats.dart';
import 'package:sound_trends/spotify_api/track.dart';
import '../spotify_api/artist.dart';
import '../utils/providers.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Artist> topArtists = [];
  List<Track> topTracks = [];
  List<Track> recentlyPlayed = [];
  PlayingTrack track = const PlayingTrack(id: 'id', name: 'name', image: 'image', artists: [], isPlaying: false);

  @override
  void initState() {
    super.initState();
    final topDataProvider = Provider.of<TopDataProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    topArtists = topDataProvider.topArtists.take(10).toList();
    topTracks = topDataProvider.topTracks.take(5).toList();

    final Authentication? userAuth = authProvider.userAuth;
    
    if (userAuth != null && !isTokenValid(userAuth.requestedAt, userAuth.expiresIn)) {
      debugPrint("I am not valid bro :(");
      debugPrint("Requested at ${userAuth.requestedAt}");
      refreshNewToken(userAuth.refreshToken).then((auth) {
        authProvider.setAuth(auth);
      });
    }

    if (topArtists.isEmpty) {
      getTopArtists(userAuth?.accessToken, 30).then((artists) {
        topDataProvider.updateTopArtists(artists);
        setState(() {
          topArtists = artists.take(10).toList();
        });
      });
    }
    if (topTracks.isEmpty) {
      getTopTracks(userAuth?.accessToken, 30).then((tracks) {
        topDataProvider.updateTopTracks(tracks);
        setState(() {
          topTracks = tracks.take(5).toList();
        });
      });
    }

    getRecentlyPlayed(userAuth?.accessToken).then((tracks) {
      setState(() {
        recentlyPlayed = tracks;
      });
    });

    void updateCurrentlyPlaying() async {
      final trackResult = await getCurrentPlaying(userAuth?.accessToken);
      PlayingTrack newTrack = trackResult;
      setState(() {
        track = newTrack;
        if (track.isPlaying) {
          debugPrint(track.name);
        } else {
          debugPrint("Not playing a song");
        }
      });
    }

    Timer.periodic(const Duration(seconds: 10), (timer) {
      updateCurrentlyPlaying();
    });

    // Initial call to updateCurrentlyPlaying
    updateCurrentlyPlaying();
  }

  @override
  Widget build(BuildContext context) {
    int selectedTab = 0;

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
                        text: 'Welcome, ',
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      TextSpan(
                        text: 'RodrigoJC20',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1EF133),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ), // Welcome User text
              track.isPlaying ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Currently playing...",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    SpotifyTrackCard(
                      songName: track.name,
                      authors: track.artists,
                      imageUrl: track.image,
                    ),
                  ],
                ),
              ) : const SizedBox.shrink(), // CurrentPlaying
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your Top Artists",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      height: 120.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: topArtists.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: SpotifyArtistCard(
                              artistName: topArtists[index].name,
                              imageUrl: topArtists[index].image,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ), // Top Artists
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your Top Songs",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    ...topTracks.asMap().entries.map((entry) {
                      final index = entry.key + 1;
                      final track = entry.value;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Text(
                              '$index.',
                              style: const TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1EF133),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: SpotifyTrackCard(
                                songName: track.name,
                                authors: track.artists,
                                imageUrl: track.image,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recently Played",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    for (var track in recentlyPlayed)
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
              ), // History
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
            } else if(selectedTab == 2){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Recommendations()));
            }
          });
        },
      ),
    );
  }
}