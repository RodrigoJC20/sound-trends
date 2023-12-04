import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AccessToken {
  final String accessToken;
  final String tokenType;
  final int expireTime;
  final DateTime createdAt;

  const AccessToken({
    required this.accessToken,
    required this.tokenType,
    required this.expireTime,
    required this.createdAt,
  });

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'access_token': String accessToken,
      'token_type': String tokenType,
      'expires_in': int expireTime,
      } => AccessToken(
        accessToken: accessToken,
        tokenType: tokenType,
        expireTime: expireTime,
        createdAt: DateTime.now(),
      ),
      _ => throw const FormatException('Failed to load Access Token'),
    };
  }
}

Future<AccessToken> loadAccessToken() async {
  final preferences = await SharedPreferences.getInstance();

  final String? storedAccessToken = preferences.getString('accessToken');
  final String? storedTokenCreationTime = preferences.getString('tokenCreatedAt');
  final int? storedExpireTime = preferences.getInt('expireTime');

  if (storedAccessToken != null && storedTokenCreationTime != null && storedExpireTime != null) {
    final DateTime storedTokenCreatedAt = DateTime.parse(storedTokenCreationTime);

    // Check if the token is expired or close to expiring within 10 minutes
    final bool isTokenExpired = DateTime.now().difference(storedTokenCreatedAt).inSeconds >= storedExpireTime - 600;

    if (!isTokenExpired) {
      return AccessToken(
        accessToken: storedAccessToken,
        tokenType: 'Bearer',
        expireTime: storedExpireTime,
        createdAt: storedTokenCreatedAt,
      );
    }
  }

  final accessToken = await fetchAccessToken();

  preferences.setString('accessToken', accessToken.accessToken);
  preferences.setInt('expireTime', accessToken.expireTime);
  preferences.setString('tokenCreatedAt', accessToken.createdAt.toIso8601String());

  return accessToken;
}

Future<AccessToken> fetchAccessToken() async {
  const String grantType = 'client_credentials';
  const String clientID = 'client-id';
  const String clientSecret = 'client-secret';

  final response = await http.post(
    Uri.parse('https://accounts.spotify.com/api/token'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'grant_type': grantType,
      'client_id': clientID,
      'client_secret': clientSecret,
    },
  );

  final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
  final accessToken = AccessToken.fromJson(responseJson);

  return accessToken;
}

class UserAuthProvider extends ChangeNotifier {
  AccessToken? _accessToken;

  AccessToken? get accessToken => _accessToken;

  void setAccessToken(AccessToken accessToken) {
    _accessToken = accessToken;
    notifyListeners();
  }
}


