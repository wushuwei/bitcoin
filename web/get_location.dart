import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MapScreen());

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Map",
      home: MapActivity(),
    );
  }
}

class MapActivity extends StatefulWidget {
  @override
  _MapActivityState createState() => _MapActivityState();
}

class _MapActivityState extends State<MapActivity> {
  late Future<Position> current_position;
  @override
  void initState() {
    super.initState();
    current_position = locateUser() ;
  }

  Future<Position> locateUser() async {
    return Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitcoin Price',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Your postion'),
        ),
        body: Center(
          child: FutureBuilder<Position>(
            future: current_position,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.latitude.toString() + "/"
                + snapshot.data!.longitude.toString());
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );

  }
}