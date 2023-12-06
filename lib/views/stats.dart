import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_trends/spotify_api/stats.dart';
import 'package:sound_trends/views/discover.dart';
import '../spotify_api/artist.dart';
import '../spotify_api/auth.dart';
import '../spotify_api/track.dart';
import '../utils/providers.dart';
import 'home.dart';



class UserStats extends StatefulWidget {
  const UserStats({super.key});

  @override
  State<UserStats> createState() => _UserStatsState();
}

class _UserStatsState extends State<UserStats> {
  List<Artist> topArtists = [];
  List<Track> topTracks = [];
  Stats? userStats;
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    final topDataProvider = Provider.of<TopDataProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userStatsProvider = Provider.of<StatsProvider>(context, listen: false);

    final Authentication? userAuth = authProvider.userAuth;

    topArtists = topDataProvider.topArtists;
    topTracks = topDataProvider.topTracks;
    userStats = userStatsProvider.getUserStats();

    if (userAuth != null && !isTokenValid(userAuth.requestedAt, userAuth.expiresIn)) {
      refreshNewToken(userAuth.refreshToken).then((auth) {
        authProvider.setAuth(auth);
      });
    }

    if (topArtists.isEmpty) {
      getTopArtists(userAuth?.accessToken, 30).then((artists) {
        topDataProvider.updateTopArtists(artists);
        setState(() {
          topArtists = artists;
        });
      });
    }
    if (topTracks.isEmpty) {
      getTopTracks(userAuth?.accessToken, 30).then((tracks) {
        topDataProvider.updateTopTracks(tracks);
        setState(() {
          topTracks = tracks;
        });
      });
    }

    if (userStats == null) {
      String trackIds = topTracks.map((track) => track.id).join(',');
      getStats(userAuth?.accessToken, trackIds).then((stats) {

        Map<String, int> genreFrequency = {};

        for (var artist in topArtists) {
          for (var genre in artist.genres) {
            genreFrequency[genre] = (genreFrequency[genre] ?? 0) + 1;
          }
        }

        List<MapEntry<String, int>> sortedGenres = genreFrequency.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

        List<MapEntry<String, int>> top4Genres = sortedGenres.take(4).toList();

        int totalArtists = topArtists.length;
        Map<String, double> popularity = {};

        for (var entry in top4Genres) {
          var genre = entry.key;
          var frequency = entry.value;
          var percentage = (frequency.toDouble() / totalArtists.toDouble()) * 100.0;
          popularity[genre] = percentage;
        }

        List<Genre> topGenres = [];

        popularity.forEach((genre, percentage) {
          topGenres.add(Genre(name: genre, popularity: percentage));
        });

        userStats = Stats(
          danceable: stats.danceable * 100,
          energy: stats.energy * 100,
          topGenres: topGenres,
        );

        setState(() {
          userStatsProvider.setStats(userStats);
          isReady = true;
        });
      });
    } else {
      setState(() {
        isReady = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int selectedTab = 1;

    return Scaffold(
      backgroundColor: const Color.fromARGB(232, 0, 0, 0),
      body: SingleChildScrollView(
        child: isReady && userStats != null ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 15.0, right: 10.0, bottom: 15.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: const [
                    TextSpan(
                      text: 'Your ',
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    TextSpan(
                      text: 'Stats',
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[800], // Dark Grey
                        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0, // Adjust the font size as needed
                              decoration: TextDecoration.none, // Remove underline
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${userStats!.topGenres?[0].name} ',
                              ),
                              TextSpan(
                                text: '${userStats!.topGenres?[0].popularity.toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  color: Color(0xFF1EF133),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ),
                  const SizedBox(width: 8.0), // Separation
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[800], // Dark Grey
                        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 26.0, // Adjust the font size as needed
                              decoration: TextDecoration.none, // Remove underline
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${userStats!.topGenres?[1].name} ',
                              ),
                              TextSpan(
                                text: '${userStats!.topGenres?[1].popularity.toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  color: Color(0xFF1EF133),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0), // Spacer
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[800], // Dark Grey
                borderRadius: BorderRadius.circular(16.0),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[800], // Dark Grey
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0, // Adjust the font size as needed
                        decoration: TextDecoration.none, // Remove underline
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${userStats!.danceable.toStringAsFixed(1)}%',
                          style: const TextStyle(
                            color: Color(0xFF1EF133),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: ' of your music is Danceable',
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0), // Spacer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[800], // Dark Grey
                          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 27.0, // Adjust the font size as needed
                                decoration: TextDecoration.none, // Remove underline
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${userStats!.topGenres?[2].name} ',
                                ),
                                TextSpan(
                                  text: '${userStats!.topGenres?[2].popularity.toStringAsFixed(0)}%',
                                  style: const TextStyle(
                                    color: Color(0xFF1EF133),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                  ),
                  const SizedBox(width: 8.0), // Separation
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[800], // Dark Grey
                        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 26.0, // Adjust the font size as needed
                              decoration: TextDecoration.none, // Remove underline
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${userStats!.topGenres?[3].name} ',
                              ),
                              TextSpan(
                                text: '${userStats!.topGenres?[3].popularity.toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  color: Color(0xFF1EF133),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0), // Spacer
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[800], // Dark Grey
                borderRadius: BorderRadius.circular(16.0),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[800], // Dark Grey
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text:  TextSpan(
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0, // Adjust the font size as needed
                        decoration: TextDecoration.none, // Remove underline
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${userStats!.energy.toStringAsFixed(1)}%',
                          style: const TextStyle(
                            color: Color(0xFF1EF133),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: ' of your music is Energetic',
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ) :
        const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80.0),
              Text(
                'Calculating your taste...',
                style: TextStyle(
                  color: Color(0xFF1EF133),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40.0),
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1EF133)))
            ],
          )
        )
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
            if(selectedTab == 2){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Recommendations()));
            } else if(selectedTab == 0){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
            }
          });
        },
      ),
    );
  }
}
