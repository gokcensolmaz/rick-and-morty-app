import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/character_model.dart';
import '../models/location_model.dart';
import '../providers/api_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('lib/assets/logo.png'),
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            Expanded(
              child: apiProvider.locations.isNotEmpty
                  ? LocationList(apiProvider: apiProvider)
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
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
            backgroundColor: Color(0xFE61ABC7),
            unselectedBackgroundColor: Color(0xFF93EC67),
            unselectedLabelStyle: const TextStyle(color: Colors.black),
            labelStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
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
              return ListView.builder(
                itemCount: location.residents?.length,
                itemBuilder: (context, index) {
                  final residentUrl = location.residents?[index];
                  return FutureBuilder<Character>(
                    future: apiProvider.getCharacterByUrl(residentUrl!),
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
                        final character = snapshot.data;
                        if (character != null) {
                          return CharacterCard(character: character);
                        } else {
                          return const SizedBox.shrink(); // Handle empty data
                        }
                      }
                    },
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No residents found for this location.'),
              );
            }
          }
        });

    throw UnimplementedError();
  }
}
class CharacterCard extends StatelessWidget {
  const CharacterCard({Key? key, required this.character}) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(character.image ?? ''),
        ),
        title: Text(character.name ?? 'Unknown Character'),
        subtitle: Text('Status: ${character.status ?? 'Unknown'}'),
        // You can display more character details here if needed
      ),
    );
  }
}


