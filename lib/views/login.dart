import 'package:flutter/material.dart';
import 'package:sound_trends/views/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF1E1E1E),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height, // Set a fixed height
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Center and space evenly
            children: [
              // First Row - Logo
              Image.asset(
                'assets/logo.png',
                width: 150,
                height: 100,
              ),
              // Second Row - Login Information
              Padding(
                padding: const EdgeInsets.all(25.0),
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
                    ),
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
                    ),
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
                                backgroundColor: const Color(0xFF1EF18C),
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
                          ),
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
                                backgroundColor: const Color(0xFF1EF18C),
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
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Or',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const home()));
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                backgroundColor: const Color(0xFF1EF18C),
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
                            ),
                          ),
                        ],
                      ),
                    ),
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
        ),
      ),
    );
  }
}