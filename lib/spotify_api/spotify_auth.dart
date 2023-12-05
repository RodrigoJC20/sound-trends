import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:pkce/pkce.dart';

class UserAuth {
  final String accessToken;
  final String tokenType;
  final String scope;
  final int expiresIn;
  final String refreshToken;
  final DateTime requestedAt;

  const UserAuth({
    required this.accessToken,
    required this.tokenType,
    required this.scope,
    required this.expiresIn,
    required this.refreshToken,
    required this.requestedAt,
  });

  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'access_token': String accessToken,
      'token_type': String tokenType,
      'scope': String scope,
      'expires_in': int expiresIn,
      'refresh_token': String refreshToken,
      } => UserAuth(
        accessToken: accessToken,
        tokenType: tokenType,
        scope: scope,
        expiresIn: expiresIn,
        refreshToken: refreshToken,
        requestedAt: DateTime.now(),
      ),
      _ => throw const FormatException('Failed to load Access Token'),
    };
  }
}

// TODO: Generate Code Verifier/Code Challenge
String generateRandomString(int length) {
  const possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final Random random = Random.secure();
  List<int> values = List.generate(length, (index) => random.nextInt(256));

  return values.map((x) => possible[x % possible.length]).join();
}

Future<void> authUser() async {
  final pkcePair  = PkcePair.generate(length: 64);
  final codeVerifier = pkcePair.codeVerifier;
  final codeChallenge = pkcePair.codeChallenge;

  const String clientId = '42878b630fd04e51873054b6ac37e01b';
  const String redirectUri = 'com.example.soundtrends://login/oauth';

  const String scope = 'user-top-read user-read-recently-played user-read-private user-read-currently-playing';
  Uri authUri = Uri.parse("https://accounts.spotify.com/authorize");

  final preferences = await SharedPreferences.getInstance();
  preferences.setString('codeVerifier', codeVerifier);

  Map<String, String> params = {
    'response_type': 'code',
    'client_id': clientId,
    'scope': scope,
    'code_challenge_method': 'S256',
    'code_challenge': codeChallenge,
    'redirect_uri': redirectUri,
  };

  authUri = authUri.replace(queryParameters: params);

  // Use url_launcher to open the URL in a browser or WebView
  if (await canLaunchUrl(authUri)) {
    await launchUrl(authUri);
  } else {
    throw 'Could not launch Spotify authorization URL';
  }
}

Future<UserAuth> fetchAccessToken(code) async {
  final preferences = await SharedPreferences.getInstance();
  final String? codeVerifier = preferences.getString('codeVerifier');

  const String clientId = '42878b630fd04e51873054b6ac37e01b';
  const String redirectUri = 'com.example.soundtrends://login/oauth';

  if (codeVerifier != null) {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'client_id': clientId,
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': redirectUri,
        'code_verifier': codeVerifier,
      },
    );

    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
    final userAuth = UserAuth.fromJson(responseJson);

    preferences.setString('accessToken', userAuth.accessToken);
    preferences.setString('scope', userAuth.scope);
    preferences.setInt('expiresIn', userAuth.expiresIn);
    preferences.setString('refreshToken', userAuth.refreshToken);
    preferences.setString('requestedAt', userAuth.requestedAt.toIso8601String());

    return userAuth;
  } else {
    return Future.error('Code verifier is null. Unable to fetch access token.');
  }
}

Future<UserAuth?> loadUserAuth() async {
  final preferences = await SharedPreferences.getInstance();

  final String? accessToken = preferences.getString('accessToken');
  final String? scope = preferences.getString('scope');
  final String? requestedAt = preferences.getString('requestedAt');
  final String? refreshToken = preferences.getString('refreshToken');
  final int? expireTime = preferences.getInt('expiresIn');

  if (accessToken != null && requestedAt != null && expireTime != null && scope != null && refreshToken != null) {
    final DateTime storedTokenCreatedAt = DateTime.parse(requestedAt);

    if (!isTokenValid(storedTokenCreatedAt, expireTime)) {
      return refreshNewToken(refreshToken);
    }

    return UserAuth(
        accessToken: accessToken,
        tokenType: 'Bearer',
        scope: scope,
        expiresIn: expireTime,
        refreshToken: refreshToken,
        requestedAt: storedTokenCreatedAt
    );
  }

  return null;
}

// TODO: Refresh Access Token
Future<UserAuth> refreshNewToken(refreshToken) async {
  final preferences = await SharedPreferences.getInstance();

  const String clientId = '42878b630fd04e51873054b6ac37e01b';

  final response = await http.post(
    Uri.parse('https://accounts.spotify.com/api/token'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken,
      'client_id': clientId,
    },
  );

  final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
  final userAuth = UserAuth.fromJson(responseJson);

  preferences.setString('accessToken', userAuth.accessToken);
  preferences.setString('scope', userAuth.scope);
  preferences.setInt('expiresIn', userAuth.expiresIn);
  preferences.setString('accessToken', userAuth.refreshToken);
  preferences.setString('requestedAt', userAuth.requestedAt.toIso8601String());

  return userAuth;
}

class UserAuthProvider extends ChangeNotifier {
  UserAuth? _userAuth;

  UserAuth? get userAuth => _userAuth;

  void setUserAuth(UserAuth userAuth) {
    _userAuth = userAuth;
    notifyListeners();
  }
}

bool isTokenValid(DateTime requestedAt, int expiresIn) {
  final remainingTime = requestedAt.add(Duration(seconds: expiresIn)).difference(DateTime.now());
  return remainingTime.inSeconds > 300; // 600 seconds = 10 minutes
}


