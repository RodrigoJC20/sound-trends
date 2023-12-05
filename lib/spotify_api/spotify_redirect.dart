import 'package:flutter/material.dart';
import 'package:sound_trends/views/home.dart';

class SpotifyRedirectView extends StatefulWidget {
  static const name = 'SpotifyRedirectView';
  static const routeName = '/oauth';

  final String query;

  const SpotifyRedirectView({super.key, required this.query});

  @override
  State<SpotifyRedirectView> createState() => _SpotifyRedirectViewState();
}

class _SpotifyRedirectViewState extends State<SpotifyRedirectView> {

  @override
  void initState() {
    super.initState();
    String code = extractAuthCode(widget.query);
    // TODO: Request the access token
    // TODO: Save the relevant information
    debugPrint(code);
    //Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Getting your stats...',
              style: TextStyle(
                color: Color(0xFF1EF133),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40.0), // Adjust spacing as needed
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1EF133)),
            ),
          ],
        ),
      ),
    );
  }
}

String extractAuthCode(String query) {
  List<String> queryList = query.split('&');

  for (String q in queryList) {
    List<String> qval = q.split('=');

    if (qval.length > 1 && qval.first.toLowerCase() == 'code') {
      return qval[1];
    }
  }
  return '';
}
