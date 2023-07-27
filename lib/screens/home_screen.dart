import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty_flutter/screens/character_screen.dart';
import 'package:rickandmorty_flutter/widgets/search_delegate.dart';
import '../models/character_model.dart';
import '../models/location_model.dart';
import '../providers/api_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getLocations();
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(height: 40),
          SizedBox(
            child: Container(
              height: 130,
              width: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/logo.png'),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                leading: Text("Find Character..."),
                trailing: Icon(Icons.search),
                onTap: () => showSearch(context: context, delegate: SearchCharacter(apiProvider)) ,
              )
            ),
          ),

          Expanded(
            child: apiProvider.locations.isNotEmpty
                ? LocationList(apiProvider: apiProvider)
                : const Center(
              child: CircularProgressIndicator(),
            ),
          )
          ,
        ]
        ,
      )
      ,
    );
  }
}

class LocationList extends StatelessWidget {
  const LocationList({super.key, required this.apiProvider});

  final ApiProvider apiProvider;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: apiProvider.locations.length,
      child: Column(
        children: <Widget>[
          ButtonsTabBar(
            backgroundColor: const Color(0xFE61ABC7),
            unselectedBackgroundColor: const Color(0xFF93EC67),
            unselectedLabelStyle:
            const TextStyle(color: Colors.black, fontFamily: 'Avenir'),
            labelStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Avenir'),
            tabs: List<Widget>.generate(
              apiProvider.locations.length,
                  (index) {
                final location = apiProvider.locations[index];
                return Tab(
                  text:
                  location.name ?? '', // Set the tab text to location name
                );
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              children: List<Widget>.generate(
                apiProvider.locations.length,
                    (index) {
                  final location = apiProvider.locations[index];
                  return CharacterList(locationId: location.id!);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CharacterList extends StatelessWidget {
  const CharacterList({Key? key, required this.locationId}) : super(key: key);
  final int locationId;

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    return FutureBuilder<Location>(
        future: apiProvider.getLocationById(locationId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final location = snapshot.data;
            if (location != null && location.residents!.isNotEmpty) {
              return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  itemCount: location.residents?.length,
                  itemBuilder: (context, index) {
                    final residentUrl = location.residents?[index];
                    return FutureBuilder<Character>(
                      future: apiProvider.getCharacterByUrl(residentUrl!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else {
                          final character = snapshot.data;
                          if (character != null) {
                            return CharacterCard(
                                character: character, index: index);
                          } else {
                            return const SizedBox.shrink(); // Handle empty data
                          }
                        }
                      },
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: Text('No residents found for this location.'),
              );
            }
          }
        });
  }
}

class CharacterCard extends StatelessWidget {
  const CharacterCard({Key? key, required this.character, required this.index})
      : super(key: key);
  final int index;
  final Character character;

  Icon _getIconByGender(String? gender) {
    if (gender == 'Female') {
      return const Icon(Icons.female, color: Colors.white, size: 30);
    } else if (gender == 'Male') {
      return const Icon(Icons.male, color: Colors.white, size: 30);
    } else {
      return const Icon(Icons.question_mark, color: Colors.white, size: 30);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
      (index % 2 == 0) ? const Color(0xFF4C4767) : const Color(0x994C4767),
      child: ListTile(
          contentPadding:
          const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
          leading: SizedBox(
            height: 120,
            width: 80,
            child: Hero(
              tag: character.id!,
              child: Image(
                image: NetworkImage(character.image ?? ''),
                fit: BoxFit.fill,
              ),
            ),
          ),
          title: Text(character.name ?? 'Unknown Character',
              textAlign: TextAlign.left),
          titleTextStyle: const TextStyle(
              fontSize: 24, color: Colors.white, fontFamily: 'Avenir'),
          trailing: _getIconByGender(character.gender),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CharacterScreen(character),
              ),
            );
          }),
    );
  }
}
