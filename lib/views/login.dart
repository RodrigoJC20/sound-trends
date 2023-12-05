import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_trends/spotify_api/spotify_auth.dart';
import 'package:sound_trends/views/home.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 75.0),
          child: Column(
            children: [
              // First Row - Logo
              Image.asset(
                'assets/logo.png',
                width: 150,
                height: 150,
              ),

              // Second Row - Login Information
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 40.0, bottom: 75.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Image.asset(
                        'assets/caption.png',
                        width: 220,
                        height: 250,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          buildSpotifyLoginButton()
                        ],
                      ),
                    ), // Spotify Button
                  ],
                ),
              ),

              // Third Row - "Sound Trends" Logo
              Image.asset(
                'assets/logo_text.png',
                width: 250,
                height: 50,
              ),
            ],
          ),
        )
      ),
    );
  }

  Widget buildSpotifyLoginButton() {
    return Expanded(
      child: ElevatedButton(
        onPressed: isLoading ? null : () => handleLoginButtonPressed(),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: const Color(0xFF1EF133),
        ),
        child: isLoading ? const CircularProgressIndicator() : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/spotify.png',
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 16.0),
            const Text(
              'Login with Spotify',
              style: TextStyle(
                color: Color(0xFF1E1E1E),
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleLoginButtonPressed() async {
    setState(() {
      isLoading = true;
    });

    await authUser();

    setState(() {
      isLoading = false;
    });

    // final accessTokenProvider = Provider.of<UserAuthProvider>(context, listen: false);
    // final storedAccessToken = accessTokenProvider.accessToken;
    //
    // if (storedAccessToken != null && isTokenValid(storedAccessToken)) {
    //   setState(() {
    //     isLoading = false;
    //   });
    //   debugPrint("From provider");
    //   debugPrint(storedAccessToken.accessToken);
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
    // } else {
    //   loadAccessToken().then((accessToken) {
    //     accessTokenProvider.setAccessToken(accessToken);
    //
    //     Future.delayed(const Duration(milliseconds: 500), () {
    //       setState(() {
    //         isLoading = false;
    //       });
    //       debugPrint("From shared preferences");
    //       debugPrint(accessToken.accessToken);
    //       Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
    //     });
    //   });
    // }
  }
}