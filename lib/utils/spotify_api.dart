import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sound_trends/utils/spotify_artist.dart';
import 'package:http/http.dart' as http;

Future<Artist> getArtistByID(String accessToken, String id) async {
  const url = 'https://api.spotify.com/v1/artists/';

  final response = await http.get(
    Uri.parse(url + id),
    headers: <String, String>{
      'Authorization': 'Bearer $accessToken',
    }
  );

  final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
  final artist = Artist.fromJson(responseJson);

  debugPrint(artist.name);

  return artist;
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

class AccessToken {
  final String accessToken;
  final String tokenType;
  final int expireTime;

  const AccessToken({
    required this.accessToken,
    required this.tokenType,
    required this.expireTime,
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
      ),
      _ => throw const FormatException('Failed to load Access Token'),
    };
  }
}
