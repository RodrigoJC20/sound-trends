import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

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

List<int> shaCustom256(String plain) {
  List<int> data = utf8.encode(plain);
  Digest digest = sha256.convert(data);
  return digest.bytes;
}

String base64encode(List<int> input) {
  String base64String = base64Url.encode(input);
  return base64String.replaceAll('-', '+').replaceAll('_', '/');
}

// TODO: User Authentication
Future<void> authUser() async {
  final codeVerifier = generateRandomString(64);
  final hashed = shaCustom256(codeVerifier);
  final codeChallenge = base64encode(hashed);

  const String clientId = 'client-id';
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

// TODO: Request Access Token
// Future<UserAuth> fetchAccessToken() async {
//
// }

// TODO: Refresh Access Token

// Future<UserAuth> loadAccessToken() async {
//   final preferences = await SharedPreferences.getInstance();
//
//   final String? storedAccessToken = preferences.getString('accessToken');
//   final String? storedTokenCreationTime = preferences.getString('tokenCreatedAt');
//   final int? storedExpireTime = preferences.getInt('expireTime');
//
//   if (storedAccessToken != null && storedTokenCreationTime != null && storedExpireTime != null) {
//     final DateTime storedTokenCreatedAt = DateTime.parse(storedTokenCreationTime);
//
//     final token = UserAuth(
//       accessToken: storedAccessToken,
//       tokenType: 'Bearer',
//       expireTime: storedExpireTime,
//       createdAt: storedTokenCreatedAt,
//     );
//
//     if (isTokenValid(token)) {
//       return token;
//     }
//   }
//
//   final accessToken = await fetchAccessToken();
//
//   preferences.setString('accessToken', accessToken.accessToken);
//   preferences.setInt('expireTime', accessToken.expireTime);
//   preferences.setString('tokenCreatedAt', accessToken.createdAt.toIso8601String());
//
//   return accessToken;
// }
//
// Future<UserAuth> fetchAccessToken() async {
//   const String grantType = 'client_credentials';
//   const String clientID = 'client-id';
//   const String clientSecret = 'client-secret';
//
//   final response = await http.post(
//     Uri.parse('https://accounts.spotify.com/api/token'),
//     headers: <String, String>{
//       'Content-Type': 'application/x-www-form-urlencoded',
//     },
//     body: {
//       'grant_type': grantType,
//       'client_id': clientID,
//       'client_secret': clientSecret,
//     },
//   );
//
//   final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
//   final accessToken = UserAuth.fromJson(responseJson);
//
//   return accessToken;
// }

class UserAuthProvider extends ChangeNotifier {
  UserAuth? _userAuth;

  UserAuth? get userAuth => _userAuth;

  void setAccessToken(UserAuth userAuth) {
    _userAuth = userAuth;
    notifyListeners();
  }
}

bool isTokenValid(UserAuth accessToken) {
  final remainingTime = accessToken.requestedAt.add(Duration(seconds: accessToken.expiresIn)).difference(DateTime.now());
  return remainingTime.inSeconds > 300; // 300 seconds = 5 minutes
}


