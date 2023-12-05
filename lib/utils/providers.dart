import 'package:flutter/material.dart';
import '../spotify_api/spotify_artist.dart';
import '../spotify_api/spotify_auth.dart';
import '../spotify_api/spotify_track.dart';

class AuthProvider extends ChangeNotifier {
  Authentication? _userAuth;

  Authentication? get userAuth => _userAuth;

  void setAuth(Authentication userAuth) {
    _userAuth = userAuth;
    notifyListeners();
  }

  String? getAccessToken() {
    return _userAuth?.accessToken;
  }
}

class TopDataProvider extends ChangeNotifier {
  List<Artist> _topArtists = [];
  List<Track> _topTracks = [];

  List<Artist> get topArtists => _topArtists;
  List<Track> get topTracks => _topTracks;

  void updateTopArtists(List<Artist> artists) {
    _topArtists = artists;
    notifyListeners();
  }

  void updateTopTracks(List<Track> tracks) {
    _topTracks = tracks;
    notifyListeners();
  }
}

class UserInfoProvider extends ChangeNotifier {

}