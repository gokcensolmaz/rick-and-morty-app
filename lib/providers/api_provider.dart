import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:rickandmorty_flutter/api_constants.dart';
import 'package:rickandmorty_flutter/models/character_model.dart';
import 'package:rickandmorty_flutter/models/episode_model.dart';
import 'package:rickandmorty_flutter/models/location_model.dart';

class ApiService{
  Future<CharacterModel?> getCharacter() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.charactersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        CharacterModel _model = characterModelResponseFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
  Future<Locations?> getLocation() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.locationsEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<LocationModel> _model = Locations().fromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
  Future<EpisodeModel?> getEpisode() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.episodesEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        EpisodeModel _model = episodeModelResponseFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}