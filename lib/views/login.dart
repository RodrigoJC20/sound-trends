import 'dart:developer';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sound_trends/views/home.dart';
import 'dart:io';
import 'package:spotify/spotify.dart' as spotify;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:crypto/crypto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:url_launcher/url_launcher_string.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}
final String scope = 'user-top-read';
const String clientId = '88ea6c48037c435085bdaf8096ce4d5d';
const String clientSecret = '536dc3a482ad4c5b9df75841e73f01c2';
const String redirectUri = 'http://localhost:8080/callback';
final _server = HttpServer;
const String link= 'https://accounts.spotify.com/es/login?continue=https%3A%2F%2Faccounts.spotify.com%2Foauth2%2Fv2%2Fauth%3Fresponse_type%3Dnone%26client_id%3Dcfe923b2d660439caf2b557b21f31221%26scope%3Demail%2Bopenid%2Bprofile%2Buser-self-provisioning%26redirect_uri%3Dhttps%253A%252F%252Fdeveloper.spotify.com%252Floggedin%26state%3D6ae2464e-b969-4043-aa93-a646882950b1';
    final authUrl = 'https://accounts.spotify.com/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=$scope&response_type=code';
class _LoginState extends State<Login> {
  Future<String> _getAuthorizationCode() async {
    final authUrl = 'https://accounts.spotify.com/authorize?'
        'client_id=$clientId&'
        'redirect_uri=$redirectUri&'
        'scope=$scope&'
        'response_type=code';

    if (await canLaunchUrlString(authUrl)) {
      await launchUrlString(authUrl,
      webViewConfiguration:WebViewConfiguration(
        enableDomStorage: true,
        enableJavaScript: true,

      )
      );
    } else {
      throw 'No se pudo lanzar la URL de autorización';
    }

    // Esperar el redireccionamiento y obtener el código de autorización
    // (Deberás implementar lógica adicional para manejar el redireccionamiento)
    return 'CÓDIGO_OBTENIDO_DEL_REDIRECCIONAMIENTO';
  }
  void authenticateWithSpotify() async {
    String clientId = '88ea6c48037c435085bdaf8096ce4d5d';
    String redirectUri = 'http://localhost:64278/';
    String scope = 'user-read-private user-read-email';

    String url = 'https://accounts.spotify.com/authorize?'
        'response_type=code'
        '&client_id=$clientId'
        '&scope=$scope'
        '&redirect_uri=$redirectUri';

    try {
      // Open a web page to authenticate with Spotify
      final result = await FlutterWebAuth.authenticate(
        url: url,
        callbackUrlScheme: redirectUri,
      );

      // Handle the result (access token, code, etc.)
      print(result);
      log(result);
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }
  Future<String> getSpotifyAccesToken()async {
    final credentials = '$clientId:$clientSecret';
  final base64Encoded = base64.encode(utf8.encode(credentials));

  final response = await http.post(
    Uri.parse('https://accounts.spotify.com/api/token'),
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Basic $base64Encoded',
    },
    body: {
      'grant_type': 'client_credentials',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final String accessToken = data['access_token'];
    log(accessToken);
    print(accessToken);
    return accessToken;
  } else {
    throw Exception('Error al obtener el token de acceso');
  }

  }

Future<List<String>> getTopSongs(String accessToken) async {
  final response = await http.get(
    Uri.parse('https://api.spotify.com/v1/me/top/tracks?limit=5'),
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> items = data['items'];

    List<String> topSongs = [];
    for (var item in items) {
      final String songName = item['name'];
      topSongs.add(songName);
    }
    log(topSongs.toString());
    return topSongs;
  } else {
    throw Exception('Error al obtener las canciones principales');
  }
}
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    WebViewController _controller =WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(authUrl));
    final WebViewWidget webViewWidget = WebViewWidget(controller: _controller);
PlatformWebViewWidgetCreationParams params =
    PlatformWebViewWidgetCreationParams(
  controller: _controller.platform,
  layoutDirection: TextDirection.ltr,
  gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
);
    bool presion = true;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF1E1E1E),
      body: presion ?
      WebViewWidget.fromPlatformCreationParams(
  params: params,
)
       : SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              onPressed: () async {
                                var aut = await _getAuthorizationCode();
                                log(aut);
                                log("yo");

                                authenticateWithSpotify();
                                log("adios");
                                var token = await getSpotifyAccesToken();
                                log("hola");
                                log(token);
                                await getTopSongs('BQAoTTdzbrBkuThT4hBvV65Uf-lmhSCa16IvsnjI8GQw-wccx5gv-H7y3eHJ8fkuFAvEiJn5QZ4mFaFLUhoH820631bJ-0V9roP-hYB7PpEvMk8wJtaNW3wdv44MG4vwbypSerrms_YH-CuruzqnVFXNiQZ1IsbO4INlvd50SY756Vt0DZqAmqeWEhOlmOeqTXt1YGHm83XiNpxPUkhu5Mt4b7rkLcpfMjBPd2M3zDXbSmKkB5L7u7PYmV8528X285kfNo1yV9Aw2qKwXHsP');
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