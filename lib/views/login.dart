import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_trends/utils/spotify_api.dart';
import 'package:sound_trends/views/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<AccessToken>? _accessToken;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
                height: 100,
              ),

              // Second Row - Login Information
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 75.0, bottom: 75.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Username',
                          filled: true,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        ),
                      ),
                    ), // User Input
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        ),
                      ),
                    ), // Password Input
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Login
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                backgroundColor: const Color(0xFF1EF133),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Color(0xFF1E1E1E),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ), // Login Button
                          const SizedBox(width: 8.0), // Middle padding
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Signup
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                backgroundColor: const Color(0xFF1EF133),
                              ),
                              child: const Text(
                                'Signup',
                                style: TextStyle(
                                  color: Color(0xFF1E1E1E),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ), // Signup Button
                        ],
                      ),
                    ), // Login/Signup Buttons
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Or',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ), // Or Text
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          buildSpotifyLogin()
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

  Expanded buildSpotifyLogin() {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          // setState(() {
          //   _accessToken = fetchAccessToken();
          // });

          Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: const Color(0xFF1EF133),
        ),
        child: Row(
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
      )
    );
  }
}