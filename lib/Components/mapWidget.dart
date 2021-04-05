import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackust_fakeust/models/area_model.dart';
import 'package:loading_animations/loading_animations.dart';

class MapWidget extends StatefulWidget {
  @override
  State<MapWidget> createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  bool loading = true;
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = [];
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.349051751000047, 114.17942283900004),
    zoom: 10,
  );

  Set<Polygon> _polygons = HashSet<Polygon>();

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

  AreaList data;

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
  }

  _handleTap(LatLng tappedPoint) {
    setState(() {
      markers = [];
      markers.add(Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          onTap: () {
            print("tomlam");
          }));
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
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set.from(markers),
          polygons: _polygons,
          // onTap: _handleTap,
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
            : Container()
      ],
    );
  }
}
