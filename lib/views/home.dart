import 'package:flutter/material.dart';
import 'package:sound_trends/views/top.dart';
import 'package:sound_trends/views/stats.dart';
import 'package:sound_trends/utils/spotify_song.dart';

import '../utils/spotify_artist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class Artist {
  final String name;
  final String imageUrl;

  Artist({required this.name, required this.imageUrl});
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    int selectedTab = 0;

    List<Artist> topArtists = [
      Artist(
        name: 'Taylor Swift',
        imageUrl: 'https://i.scdn.co/image/ab6761610000f178a03696716c9ee605006047fd',
      ),
      Artist(
        name: 'Taylor Swift',
        imageUrl: 'https://i.scdn.co/image/ab6761610000f178a03696716c9ee605006047fd',
      ),
      Artist(
        name: 'Taylor Swift',
        imageUrl: 'https://i.scdn.co/image/ab6761610000f178a03696716c9ee605006047fd',
      ),
      Artist(
        name: 'Taylor Swift',
        imageUrl: 'https://i.scdn.co/image/ab6761610000f178a03696716c9ee605006047fd',
      ),
      Artist(
        name: 'Taylor Swift',
        imageUrl: 'https://i.scdn.co/image/ab6761610000f178a03696716c9ee605006047fd',
      ),
    ];

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
                    SpotifySongCard(
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
                              imageUrl: topArtists[index].imageUrl,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Top Songs",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text(
                          '1.',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1EF133),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: SpotifySongCard(
                            songName: "Song 1",
                            authors: ["Author 2"],
                            imageUrl: "https://i.scdn.co/image/ab6761610000f178a03696716c9ee605006047fd",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text(
                          '2.',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1EF133),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: SpotifySongCard(
                            songName: "Song 1",
                            authors: ["Author 2"],
                            imageUrl: "https://i.scdn.co/image/ab6761610000f178a03696716c9ee605006047fd",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text(
                          '3.',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1EF133),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: SpotifySongCard(
                            songName: "Song 1",
                            authors: ["Author 2"],
                            imageUrl: "https://i.scdn.co/image/ab6761610000f178a03696716c9ee605006047fd",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recently Played",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    SpotifySongCard(
                      songName: "History Song 1",
                      authors: ["Author 1"],
                      imageUrl: "https://i.scdn.co/image/ab6761610000f178a03696716c9ee605006047fd",
                    ),
                    SizedBox(height: 8.0),
                    SpotifySongCard(
                      songName: "History Song 1",
                      authors: ["Author 1"],
                      imageUrl: "https://i.scdn.co/image/ab6761610000f178a03696716c9ee605006047fd",
                    ),
                    SizedBox(height: 8.0),
                    SpotifySongCard(
                      songName: "History Song 1",
                      authors: ["Author 1"],
                      imageUrl: "https://i.scdn.co/image/ab6761610000f178a03696716c9ee605006047fd",
                    ),
                    SizedBox(height: 8.0),
                    SpotifySongCard(
                      songName: "History Song 1",
                      authors: ["Author 1"],
                      imageUrl: "https://i.scdn.co/image/ab6761610000f178a03696716c9ee605006047fd",
                    ),
                    SizedBox(height: 8.0),
                    SpotifySongCard(
                      songName: "History Song 1",
                      authors: ["Author 1"],
                      imageUrl: "https://i.scdn.co/image/ab6761610000f178a03696716c9ee605006047fd",
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
  }
}