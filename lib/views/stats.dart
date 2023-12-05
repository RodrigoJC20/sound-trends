import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_trends/views/recommendations.dart';
import '../spotify_api/spotify_artist.dart';
import '../spotify_api/spotify_track.dart';
import '../utils/providers.dart';
import 'home.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  List<Artist> topArtists = [];
  List<Track> topTracks = [];
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    final userAuthProvider = Provider.of<UserAuthProvider>(context, listen: false);
    final String? accessToken = userAuthProvider.getAccessToken();

    getTopArtists(accessToken, 30).then((artists) {
      setState(() {
        topArtists = artists;
      });
      getTopTracks(accessToken, 30).then((tracks) {
        setState(() {
          topTracks = tracks;
          isReady = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int selectedTab = 1;

    return Scaffold(
      backgroundColor: const Color.fromARGB(232, 0, 0, 0),
      body: SingleChildScrollView(
        child: isReady ? Column(
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
                      text: 'Your',
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
                          text: const TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0, // Adjust the font size as needed
                              decoration: TextDecoration.none, // Remove underline
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Pop ',
                              ),
                              TextSpan(
                                text: '82%',
                                style: TextStyle(
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
                          text: const TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 26.0, // Adjust the font size as needed
                              decoration: TextDecoration.none, // Remove underline
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Urban Latino ',
                              ),
                              TextSpan(
                                text: '38%',
                                style: TextStyle(
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
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[800], // Dark Grey
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0, // Adjust the font size as needed
                        decoration: TextDecoration.none, // Remove underline
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '88%',
                          style: TextStyle(
                            color: Color(0xFF1EF133),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
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
                            text: const TextSpan(
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 27.0, // Adjust the font size as needed
                                decoration: TextDecoration.none, // Remove underline
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Country ',
                                ),
                                TextSpan(
                                  text: '60%',
                                  style: TextStyle(
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
                          text: const TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 26.0, // Adjust the font size as needed
                              decoration: TextDecoration.none, // Remove underline
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'American Rap ',
                              ),
                              TextSpan(
                                text: '78%',
                                style: TextStyle(
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
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0, // Adjust the font size as needed
                        decoration: TextDecoration.none, // Remove underline
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '74%',
                          style: TextStyle(
                            color: Color(0xFF1EF133),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' of your music is Instrumental',
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
