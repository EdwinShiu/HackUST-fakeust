import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackust_fakeust/models/mapDataProvider.dart';
import 'package:hackust_fakeust/states/currentUser.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackust_fakeust/Pages/SitePage/sitePage.dart';
import 'package:hackust_fakeust/models/area_model.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

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
  Map<String, LatLng> _circleCenters = Map<String, LatLng>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Circle> _circle = HashSet<Circle>();
  Set<Marker> _markers = HashSet<Marker>();

  static final CameraPosition initPosition = CameraPosition(
    target: LatLng(22.349051751000047, 114.17942283900004),
    zoom: 10,
  );

  // bool _isInArea(List<LatLng> vertices) {
  //   LatLng cpos = LatLng(_locationData.latitude, _locationData.longitude);
  //   int intersectCount = 0;
  //   for (int j = 0; j < vertices.length - 1; j++) {
  //     if (rayCastIntersect(cpos, vertices[j], vertices[j + 1])) {
  //       intersectCount++;
  //     }
  //   }

  //   return ((intersectCount % 2) == 1);
  // }

  // bool rayCastIntersect(LatLng tap, LatLng vertA, LatLng vertB) {
  //   double aY = vertA.latitude;
  //   double bY = vertB.latitude;
  //   double aX = vertA.longitude;
  //   double bX = vertB.longitude;
  //   double pY = tap.latitude;
  //   double pX = tap.longitude;

  //   if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
  //     return false;
  //   }

  //   double m = (aY - bY) / (aX - bX);
  //   double bee = (-aX) * m + aY;
  //   double x = (pY - bee) / m;

  //   return x > pX;
  // }

  // String findRegion() {
  //   for (var i = 0; i < data.areas.length; i++) {
  //     for (var j = 0; j < data.areas[i].latlng.length; j++) {
  //       List<LatLng> latLngs = [];
  //       for (var k = 0; k < data.areas[i].latlng[j].length; k++) {
  //         double latitude = data.areas[i].latlng[j][k][1];
  //         double longitude = data.areas[i].latlng[j][k][0];
  //         latLngs.add(LatLng(latitude, longitude));
  //       }
  //       if (_isInArea(latLngs)) return data.areas[i].location;
  //     }
  //   }
  //   return "None";
  // }

  // bool _isInCircle(LatLng centerPoint, double r) {
  //   LatLng cpos = LatLng(_locationData.latitude, _locationData.longitude);
  //   var ky = 40000 / 360;
  //   var kx = cos(pi * centerPoint.latitude / 180.0) * ky;
  //   var dx = (centerPoint.longitude - cpos.longitude).abs() * kx;
  //   var dy = (centerPoint.latitude - cpos.latitude).abs() * ky;
  //   return sqrt(dx * dx + dy * dy) <= r;
  // }

  // String findLocation() {
  //   String location = "None";
  //   _circleCenters.forEach((key, value) {
  //     if (_isInCircle(value, 0.1)) location = key;
  //   });
  //   return location;
  // }

  void _setMarker() async {
    await FirebaseFirestore.instance
        .collection('locations')
        .get()
        .then((value) => value.docs.forEach((element) {
              _markers.add(Marker(
                  markerId: MarkerId(element.data()['lid']),
                  position: LatLng(element.data()['latlng'].latitude,
                      element.data()['latlng'].longitude),
                  onTap: () {}));
            }));
  }

  void _setCircle() async {
    await FirebaseFirestore.instance
        .collection('locations')
        .get()
        .then((value) => value.docs.forEach((element) {
              LatLng _center = LatLng(element.data()['latlng'].latitude,
                  element.data()['latlng'].longitude);
              _circleCenters[element.data()['location_name']] = _center;
              _circle.add(Circle(
                  circleId: CircleId(element.data()['lid']),
                  center: _center,
                  radius: 100.0,
                  fillColor: Colors.redAccent.withOpacity(0.5),
                  strokeWidth: 0,
                  onTap: () {}));
            }));
    Provider.of<MapDataProvider>(context, listen: false)
        .addCircle(_circleCenters);
  }

  void _setPolygons() async {
    Map<String, dynamic> travelledRegion = await FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<CurrentUser>(context, listen: false).getUid)
        .get()
        .then((value) => value.data()['travelled_regions']);
    print(travelledRegion);
    for (var i = 0; i < data.areas.length; i++) {
      print("Start " + i.toString());
      Color color = travelledRegion.containsKey(i.toString()) &&
              travelledRegion[i.toString()] > 0
          ? Colors.blue
              .withOpacity(0.5)
              .withAlpha(255 * travelledRegion[i.toString()] ~/ 10)
          : Colors.grey[800].withOpacity(0.5);
      for (var j = 0; j < data.areas[i].latlng.length; j++) {
        List<LatLng> polygonLatLngs = [];
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
            strokeColor: Colors.grey[300],
            fillColor: color,
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
      Provider.of<MapDataProvider>(context, listen: false)
          .setPolygonsLatLngs(data);
    });
  }

  void asyncMethod() async {
    await loadJsonData();
    _setMarker();
    _setCircle();
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
    var loc = await Geolocator.getCurrentPosition();
    LocationData locationData = LocationData.fromMap(
        {"latitude": loc.latitude, "longitude": loc.longitude});
    Provider.of<CurrentUser>(context, listen: false)
        .updateLocation(locationData);
    Provider.of<MapDataProvider>(context, listen: false)
        .setLocation(locationData);

    _locationData = locationData;

    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);

    String locationName =
        Provider.of<MapDataProvider>(context, listen: false).findLocation();
    currentUser.updateLocationName(locationName);

    String regionName =
        Provider.of<MapDataProvider>(context, listen: false).findRegion();
    currentUser.updateRegionName(regionName);

    FirebaseFirestore.instance
        .collection('locations')
        .where('location_name', isEqualTo: locationName)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty)
        currentUser.updateLocationId(snapshot.docs[0]['lid']);
      else
        currentUser.updateLocationId("other");
    });

    FirebaseFirestore.instance
        .collection('regions')
        .where('region_name', isEqualTo: regionName)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty)
        currentUser.updateRegionId(snapshot.docs[0]['rid']);
    });
  }

  _handleTap(LatLng tappedPoint) {
    setState(() {
      _markers.add(Marker(
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
            location.onLocationChanged.listen((l) {
              _locationData = l;
              Provider.of<CurrentUser>(context, listen: false)
                  .updateLocation(_locationData);
              Provider.of<MapDataProvider>(context, listen: false)
                  .setLocation(_locationData);
            });
          },
          // markers: _markers,
          circles: _circle,
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
            : Container(),
        FloatingActionButton(
          onPressed: () => print(
              Provider.of<MapDataProvider>(context, listen: false)
                  .findLocation()),
          heroTag: "findlocation",
        ),
        Container(
          margin: const EdgeInsets.only(top: 60.0),
          child: FloatingActionButton(
            onPressed: () => print(
                Provider.of<MapDataProvider>(context, listen: false)
                    .findRegion()),
            heroTag: "findregion",
          ),
        ),
      ],
    );
  }
}
