import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_trends/views/top.dart';
import 'package:sound_trends/views/stats.dart';
import 'package:sound_trends/spotify_api/spotify_track.dart';
import '../spotify_api/spotify_artist.dart';
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

  @override
  void initState() {
    super.initState();
    final topDataProvider = Provider.of<TopDataProvider>(context, listen: false);
    final userAuthProvider = Provider.of<UserAuthProvider>(context, listen: false);

    topArtists = topDataProvider.topArtists;
    topTracks = topDataProvider.topTracks;

    final String? accessToken = userAuthProvider.getAccessToken();

    if (topDataProvider.topArtists.isEmpty) {
      getTopArtists(accessToken).then((artists) {
        topDataProvider.updateTopArtists(artists);
        setState(() {
          topArtists = artists;
        });
      });
    }
    if (topDataProvider.topTracks.isEmpty) {
      getTopTracks(accessToken).then((tracks) {
        topDataProvider.updateTopTracks(tracks);
        setState(() {
          topTracks = tracks;
        });
      });
    }

    getRecentlyPlayed(accessToken).then((tracks) {
      setState(() {
        recentlyPlayed = tracks;
      });
    });
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
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Currently playing...",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    SpotifyTrackCard(
                      songName: "Song Name",
                      authors: ["Author 1", "Author 2"],
                      imageUrl: "https://i.scdn.co/image/ab6761610000f178a03696716c9ee605006047fd",
                    ),
                  ],
                ),
              ), // Last Song Played
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
            label: 'Top',
          ),
        ],
        currentIndex: selectedTab,
        onTap: (int index) {
          setState(() {
            selectedTab = index;
            if(selectedTab == 1){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Stats()));
            } else if(selectedTab == 2){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Top()));
            }
          });
        },
      ),
    );

    List<SpotifyTrackCard> buildRecentlyPlayedCards(List<Track> recentlyPlayed) {
      return recentlyPlayed.map((track) {
        return SpotifyTrackCard(
          songName: track.name,
          authors: track.artists,
          imageUrl: track.image,
        );
      }).toList();
    }
  }
}