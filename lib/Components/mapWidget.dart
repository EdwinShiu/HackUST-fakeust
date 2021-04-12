import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackust_fakeust/Pages/SitePage/sitePage.dart';
import 'package:hackust_fakeust/models/area_model.dart';
import 'package:loading_animations/loading_animations.dart';

class MapWidget extends StatefulWidget {
  @override
  State<MapWidget> createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  AreaList data;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData currentLocation;
  Location location = new Location();
  LocationData _locationData;
  bool cleared = false;
  bool loading = true;
  Completer<GoogleMapController> _controller = Completer();
  Set<Polygon> _polygons = HashSet<Polygon>();
  List<Marker> markers = [];

  static final CameraPosition initPosition = CameraPosition(
    target: LatLng(22.349051751000047, 114.17942283900004),
    zoom: 10,
  );

  void _setPolygons() async {
    bool traveled = true;
    for (var i = 0; i < data.areas.length; i++) {
      print("Start " + i.toString());
      Color color =
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5);
      for (var j = 0; j < data.areas[i].latlng.length; j++) {
        List<LatLng> polygonLatLngs = List<LatLng>();
        for (var k = 0; k < data.areas[i].latlng[j].length; k++) {
          double latitude = data.areas[i].latlng[j][k][1];
          // print(latitude);
          double longitude = data.areas[i].latlng[j][k][0];
          // print(longitude);
          polygonLatLngs.add(LatLng(latitude, longitude));
        }
        _polygons.add(
          Polygon(
            polygonId: PolygonId(data.areas[i].location + "-" + j.toString()),
            points: polygonLatLngs,
            strokeWidth: 1,
            fillColor: traveled ? color : Colors.grey.withOpacity(0.5),
            consumeTapEvents: true,
            onTap: () {
              print(data.areas[i].location + "-" + j.toString());
              print(data.areas[i].latlng[j][0][0].toString() +
                  " " +
                  data.areas[i].latlng[j][0][1].toString());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SitePage(
                            country: "Hong Kong",
                            site: data.areas[i].location,
                            description:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse lacinia tortor ut erat interdum, vitae efficitur mi molestie. Phasellus viverra nibh sit amet dui facilisis, pellentesque varius eros lacinia. In nec rhoncus tortor. Nullam id est quis ex interdum maximus. Cras semper porta sollicitudin. Nam a tincidunt dolor, non lobortis velit. Nulla malesuada elit ac mauris efficitur viverra. Duis quam libero, pulvinar sit amet vulputate nec, aliquam vitae dui. Mauris porta ante a nisl feugiat rutrum. Donec commodo tincidunt accumsan.",
                          )));
            },
          ),
        );
      }
      print("Complete " + i.toString());
    }
    setState(() {
      loading = false;
    });
  }

  Future loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/data/latlng.json');
    final jsonResponse = json.decode(jsonString);

    setState(() {
      data = new AreaList.fromJson(jsonResponse);
    });
  }

  void asyncMethod() async {
    await loadJsonData();
    _setPolygons();

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    print(_permissionGranted);
    _locationData = await location.getLocation();
  }

  _handleTap(LatLng tappedPoint) {
    setState(() {
      markers = [];
      markers.add(Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          onTap: () {}));
    });
  }

  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: initPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set.from(markers),
          polygons: _polygons,
          buildingsEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onCameraMove: (CameraPosition cameraPosition) {
            // print(cameraPosition.zoom);
            if (cameraPosition.zoom > 13 && !cleared)
              setState(() {
                _polygons.clear();
                cleared = true;
              });
            else if (cameraPosition.zoom <= 13 && cleared)
              setState(() {
                _setPolygons();
                cleared = false;
              });
          },
          onTap: _handleTap,
        ),
        loading
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: LoadingRotating.square(
                  duration: Duration(milliseconds: 500),
                ),
              )
            : Container(),
        // FloatingActionButton(
        //   onPressed: () => print(_locationData),
        //   heroTag: Null,
        // ),
      ],
    );
  }
}
