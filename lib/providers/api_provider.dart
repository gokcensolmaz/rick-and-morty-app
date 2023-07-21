import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmorty_flutter/models/character_model.dart';
import 'package:rickandmorty_flutter/models/episode_model.dart';
import 'package:rickandmorty_flutter/models/location_model.dart';

class ApiProvider with ChangeNotifier {
  String baseUrl = 'rickandmortyapi.com';
  String charactersEndpoint = '/api/character';
  String locationsEndpoint = '/api/location';
  String episodesEndpoint = '/api/episode';
  List<Location> locations = [];
  List<Location> characters = [];


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


  /*Future<void> getEpisodes() async {
    final result = await http.get(Uri.https('$baseUrl/$episodesEndpoint'));
    final response =  EpisodeModel.fromJson(json.decode(result.body));
    print(response.results);
  }
  Future<void> getCharacters() async {
    final result = await http.get(Uri.https('$baseUrl/$charactersEndpoint'));
    final response =  CharacterModel.fromJson(json.decode(result.body));
    print(response.results);
  }*/
}