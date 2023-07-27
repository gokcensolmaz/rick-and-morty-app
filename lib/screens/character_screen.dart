import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/character_model.dart';
import '../providers/api_provider.dart';

class CharacterScreen extends StatefulWidget {
  final Character character;

  CharacterScreen(this.character, {super.key});

  @override
  CharacterState createState() => CharacterState(character);
}

class CharacterState extends State<CharacterScreen> {
  CharacterState(character);

  String? getEpisodeNumber(episodeUrls) {
    List<dynamic> episodeNumbers = episodeUrls.map((url) {
      String episodeNumberStr = url.split('/').last;
      return int.tryParse(episodeNumberStr) ?? -1;
    }).toList();
    return episodeNumbers.join(', ');
  }

  Icon _getIconByGender(String? gender) {
    if (gender == 'Female') {
      return const Icon(Icons.female, color: Colors.black, size: 30);
    } else if (gender == 'Male') {
      return const Icon(Icons.male, color: Colors.white, size: 30);
    } else {
      return const Icon(Icons.question_mark, color: Colors.white, size: 30);
    }
  }

  Icon _getIconByStatus(String? status) {
    if (status == 'Alive') {
      return const Icon(Icons.circle, color: Colors.green, size: 10);
    } else if (status == 'Dead') {
      return const Icon(Icons.circle, color: Colors.red, size: 15);
    } else {
      return const Icon(Icons.circle, color: Colors.grey, size: 15);
    }
  }

  String? convertDate(date) {
    String dateTimeString = date;

    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDateTime =
        DateFormat('d MMM y,\n HH:mm:ss').format(dateTime);

    return formattedDateTime;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.character.name ?? 'Unknown Character',
          style: const TextStyle(
              fontFamily: 'Avenir', fontWeight: FontWeight.w600, fontSize: 28),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.character.id!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SizedBox(
                    height: 270,
                    width: 270,
                    child: Image(
                      image: NetworkImage(widget.character.image ?? ''),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Card(
                    color: const Color(0x994C4767),
                    child: SizedBox(
                      height: 85,
                      width: 100,
                      child: Column(
                        children: [
                          const Text(
                            "Gender: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'Avenir',
                            ),
                          ),
                          const SizedBox(height: 10),
                          _getIconByGender(widget.character.gender),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: const Color(0x994C4767),
                    child: SizedBox(
                      height: 85,
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Status: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'Avenir',
                              )),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _getIconByStatus(widget.character.status),
                              const SizedBox(width: 6),
                              Text("${widget.character.status}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18,
                                    fontFamily: 'Avenir',
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: const Color(0x994C4767),
                    child: SizedBox(
                      height: 85,
                      width: 100,
                      child: Column(
                        children: [
                          const Text("Species: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'Avenir',
                              )),
                          const SizedBox(height: 10),
                          Text(
                            "${widget.character.species}",
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              fontFamily: 'Avenir',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SizedBox(
              height: 500,
              width: 380,
              child: Column(
                children: [
                  Text(
                    "EPISODES",
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  EpisodeList(size: size, character: widget.character,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EpisodeList extends StatefulWidget {
  const EpisodeList({super.key, required this.size, required this.character});

  final Size size;
  final Character character;

  @override
  State<StatefulWidget> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  @override
  void initState() {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getEpisodes(widget.character);
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    return SizedBox(
      height: widget.size.height * 0.5,
      child: ListView.builder(
          itemCount: apiProvider.episodes.length,
          itemBuilder: (context, index) {
            final episode = apiProvider.episodes[index];
            return ListTile(
                leading: Text(episode.episode!,style: TextStyle(fontSize: 12),),
                title: Text(episode.name!),
                trailing: Text(episode.airDate!));
          }),
    );
  }
}
