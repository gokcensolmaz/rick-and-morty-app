import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/character_model.dart';

class CharacterScreen extends StatefulWidget {
  final Character character;

  CharacterScreen(this.character,
      {super.key}); //  ructor should pass the character parameter

  @override
  CharacterState createState() => CharacterState(character);
}

class CharacterState extends State<CharacterScreen> {
  CharacterState(character); //  ructor should pass the character parameter

  String? getEpisodeNumber(episodeUrls) {
    List<dynamic> episodeNumbers = episodeUrls.map((url) {
      String episodeNumberStr =
          url.split('/').last; // Extract the last part of the URL
      return int.tryParse(episodeNumberStr) ??
          -1; // Parse the episode number as an integer
    }).toList();
    return episodeNumbers.join(', ');
  }

  String? convertDate(date) {
    String dateTimeString = date;

    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDateTime = DateFormat('d MMM y,\n HH:mm:ss').format(dateTime);

    return formattedDateTime;
  }

  @override
  void initState() {
    super.initState();
    print("character");
    // You can perform initialization tasks here
  }

  @override
  Widget build(BuildContext context) {
    // Implement the build method to return the UI of the widget
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.character.name ?? 'Unknown Character',
          style: const TextStyle(
              fontFamily: 'Avenir', fontWeight: FontWeight.w600, fontSize: 28),
        ),
      ),
      body: Center(
        child: Column(children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              width: 275,
              height: 275,
              child: Image(
                  image: NetworkImage(widget.character.image ?? ''),
                  fit: BoxFit.contain)),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            // Horizontal: 20, Vertical: 20, Bottom: 0
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text(
                      'Status:',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      widget.character.status ?? 'Unknown Status',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  ListTile(
                    title: const Text(
                      'Species:',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      widget.character.species ?? 'Unknown Species',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  ListTile(
                      title: const Text(
                      'Gender:',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      widget.character.gender ?? 'Unknown Gender',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  ListTile(
                      title: const Text(
                      'Location:',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      widget.character.location?.name ?? 'Unknown Location',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  ListTile(
                      title: const Text(
                      'Episodes:',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      getEpisodeNumber(widget.character.episode) ??
                          'Unknown Episode',
                      style: const TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  ListTile(
                    title: const Text(
                      'Created at \n (in API):',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      convertDate(widget.character.created) ??
                          'Unknown Created',
                      style: const TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
