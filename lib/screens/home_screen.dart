import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

import '../models/location_model.dart';
import '../providers/api_provider.dart';


class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();

}
class _HomeState extends State<HomeScreen> {
  late List<LocationModel>? _locationModel = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }
  void _getData() async {
    _locationModel = (await ApiService().getLocation())! as List<LocationModel>?;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }


  @override
  Widget build(BuildContext context) {
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
            FutureBuilder<List<LocationModel>>(
                builder: (c,s){//What c and s
                  if(s.hasData){
                    List<Tab> tabs = new List<Tab>();
                    for (int i = 0; i < s.data!.length; i++) {
                      tabs.add(Tab(
                        child: Text(
                          s.data[i].results.,
                          style: TextStyle(color: Colors.white),
                        ),
                      ));
                    }
                  }
                }
            )

          ],
        ),
      ),
    );
  }


}