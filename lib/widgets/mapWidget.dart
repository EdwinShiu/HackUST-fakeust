import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackust_fakeust/models/area_model.dart';

class MapWidget extends StatefulWidget {
  @override
  State<MapWidget> createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = [];
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.349051751000047, 114.17942283900004),
    zoom: 10,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(22.427809207836, 114.23982863256221),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Set<Polygon> _polygons = HashSet<Polygon>();

  void _setPolygons() {
    bool traveled = true;
    for (var i = 0; i < data.areas.length; i++) {
      print("Start " + i.toString());
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
            fillColor: traveled
                ? Color((Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(0.5)
                : Colors.grey.withOpacity(0.5),
            onTap: () => print("TAP"),
          ),
        );
      }
      print("Complete " + i.toString());
    }
  }

  AreaList data;

  Future loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/latlng.json');
    final jsonResponse = json.decode(jsonString);

    setState(() {
      data = new AreaList.fromJson(jsonResponse);
    });
  }

  void asyncMethod() async {
    await loadJsonData();
    _setPolygons();
  }

  _handleTap(LatLng tappedPoint) {
    setState(() {
      markers = [];
      markers.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: Set.from(markers),
      polygons: _polygons,
      // onTap: _handleTap,
    );
  }
}
