import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First Row - Logo
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Image.asset(
                'assets/logo.png', // Replace with the path to your first logo
                width: 100, // Adjust the size as needed
                height: 100,
              ),
            ),

            // Second Row - Login Information
            Column(
              children: [
                // Username Input
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      filled: true,
                    ),
                  ),
                ),

                // Password Input
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      filled: true,
                    ),
                  ),
                ),

                // Two Buttons (Login and Signup)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add login logic here
                      },
                      child: const Text('Login'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add signup logic here
                      },
                      child: const Text('Signup'),
                    ),
                  ],
                ),

                // Or Text
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Or',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                // Spotify Login Button
                ElevatedButton(
                  onPressed: () {
                    // Add Spotify login logic here
                  },
                  child: const Text('Login with Spotify'),
                ),
              ],
            ),

            // Third Row - "Sound Trends" Logo
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Image.asset(
                'assets/logo_text.png', // Replace with the path to your second logo
                width: 150, // Adjust the size as needed
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
