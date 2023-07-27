import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmorty_flutter/models/character_model.dart';
import 'package:rickandmorty_flutter/models/location_model.dart';

import '../models/episode_model.dart';

class ApiProvider with ChangeNotifier {
  String baseUrl = 'rickandmortyapi.com';
  String charactersEndpoint = '/api/character';
  String locationsEndpoint = '/api/location';
  String episodesEndpoint = '/api/episode';
  List<Location> locations = [];
  List<Location> characters = [];
  List<Episode> episodes = [];


  Future<void> getLocations() async {
    final result = await http.get(Uri.https(baseUrl, locationsEndpoint));
    final response = LocationModel.fromJson(json.decode(result.body));
    locations.addAll(response.results ?? []);
    notifyListeners();
  }
  Future<Location> getLocationById(int? locationId) async {
    final result = await http.get(Uri.parse('http://$baseUrl$locationsEndpoint/$locationId'));
    final response = Location.fromJson(json.decode(result.body));
    return response;
  }

  Future<Character> getCharacterByUrl(String characterUrl) async {
    final result = await http.get(Uri.parse(characterUrl));
    final response = Character.fromJson(json.decode(result.body));
    return response;
  }

  Future <List<Character>> getCharacter(String name) async {
    final result = await http.get(Uri.https(baseUrl, charactersEndpoint, {'name' : name}));
    final response = CharacterModel.fromJson(json.decode(result.body));
    return response.results!;
  }

  Future<List<Episode>> getEpisodes(Character character) async {
    episodes = [];
    for(var i = 0; i  < character.episode!.length; i++){
      final result = await http.get(Uri.parse(character.episode![i]));
      final response = Episode.fromJson(json.decode(result.body));
      episodes.add(response);
      notifyListeners();
    }
    return episodes;
  }
}
