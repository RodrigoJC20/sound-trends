import 'package:flutter/material.dart';
import 'package:sound_trends/spotify_api/spotify_auth.dart';
import 'package:sound_trends/views/login.dart';
import 'package:provider/provider.dart';
import 'package:sound_trends/spotify_api/spotify_redirect.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserAuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoundTrends',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E1E1E)),
        useMaterial3: true,
      ),
      home: const Login(),
      onGenerateRoute: (settings) {
        Uri uri = Uri.parse(settings.name.toString());
        switch(uri.path) {
          case SpotifyRedirectView.routeName:
            {
              String query = uri.query;
              return MaterialPageRoute(builder: (context) => SpotifyRedirectView(query: query,));
            }
        }
        switch(settings.name) {
          default:
            return MaterialPageRoute(builder: (context) => const Login());
        }
      },
    );
  }
}
