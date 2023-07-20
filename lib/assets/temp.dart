DefaultTabController(
length: _locationModel!.length,
child: Column(children: <Widget>[
ButtonsTabBar(
backgroundColor: Colors.red,
unselectedBackgroundColor: Colors.grey[300],
unselectedLabelStyle: const TextStyle(color: Colors.black),
labelStyle: const TextStyle(
color: Colors.white, fontWeight: FontWeight.bold),
tabs: const [
Tab(
icon: Icon(Icons.directions_car),
text: "car",
),
Tab(
icon: Icon(Icons.directions_transit),
text: "transit",
),
Tab(icon: Icon(Icons.directions_bike),text: "bike"),
Tab(icon: Icon(Icons.directions_car),text: "car"),
Tab(icon: Icon(Icons.directions_transit),text: "transit"),
Tab(icon: Icon(Icons.directions_bike),text: "bike"),
],
),
]),
),
ListTile(
title: Text(locationBarItems[0]),
leading: Icon(Icons.directions_bike),

),
ListTile(
title: Text(locationBarItems[1]),
leading: Icon(Icons.directions_bike),

),
ListTile(
title: Text(locationBarItems[2]),
leading: Icon(Icons.directions_bike),

)