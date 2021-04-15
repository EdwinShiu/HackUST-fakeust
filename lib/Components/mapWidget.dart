import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackust_fakeust/Components/permissionDialog.dart';
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
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Circle> _circle = HashSet<Circle>();
  Set<Marker> _markers = HashSet<Marker>();
  CurrentUser currentUser;

  static final CameraPosition initPosition = CameraPosition(
    target: LatLng(22.349051751000047, 114.17942283900004),
    zoom: 10,
  );

  // void _setMarker() async {
  //   await FirebaseFirestore.instance
  //       .collection('locations')
  //       .get()
  //       .then((value) => value.docs.forEach((element) {
  //             _markers.add(Marker(
  //                 markerId: MarkerId(element.data()['lid']),
  //                 position: LatLng(element.data()['latlng'].latitude,
  //                     element.data()['latlng'].longitude),
  //                 onTap: () {}));
  //           }));
  // }

  void _setCircle() async {
    await FirebaseFirestore.instance.collection('locations').get().then(
          (snapshot1) => snapshot1.docs.forEach(
            (element1) {
              bool _hasEvent = false;
              Color _color;
              FirebaseFirestore.instance.collection('events').get().then(
                (snapshot2) {
                  snapshot2.docs.forEach((element2) {
                    if (element2
                        .data()['lid']
                        .contains(element1.data()['lid'])) {
                      _hasEvent = true;
                      if (element2.data()['participants'] != null &&
                          element2
                              .data()['participants']
                              .contains(currentUser.getUid)) {
                        _color = Color(int.parse(element2.data()['color']));
                      }
                    }
                  });
                  LatLng _center = LatLng(element1.data()['latlng'].latitude,
                      element1.data()['latlng'].longitude);

                  Color color =
                      _hasEvent ? _color ?? Colors.grey : Colors.white;
                  Provider.of<MapDataProvider>(context, listen: false)
                      .addCircle(element1.data()['location_name'], _center);
                  _circle.add(Circle(
                      circleId: CircleId(element1.data()['lid']),
                      center: _center,
                      radius: 100.0,
                      fillColor: color.withOpacity(0.6),
                      strokeWidth: 0,
                      consumeTapEvents: true,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SitePage(
                                      country: "Hong Kong",
                                      site: "location",
                                      id: element1.data()['lid'],
                                    )));
                      }));
                  _color = null;
                },
              );
            },
          ),
        );
  }

  void _setPolygons() async {
    Map<String, dynamic> travelledRegion = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.getUid)
        .get()
        .then((value) => value.data()['travelled_regions']);
    for (var i = 0; i < data.areas.length; i++) {
      Color color;
      // int eventCount = await FirebaseFirestore.instance
      //     .collection('regions')
      //     .doc(i.toString())
      //     .get()
      //     .then((value) => value.data()['event_count']);
      travelledRegion != null
          ? color = travelledRegion.containsKey(i.toString()) &&
                  travelledRegion[i.toString()] > 0
              ? Colors.blue
                  .withOpacity(0.5)
                  .withAlpha(255 * travelledRegion[i.toString()] ~/ 10)
              : Colors.grey[800].withOpacity(0.5)
          : color = Colors.grey[800].withOpacity(0.5);
      for (var j = 0; j < data.areas[i].latlng.length; j++) {
        List<LatLng> polygonLatLngs = [];
        for (var k = 0; k < data.areas[i].latlng[j].length; k++) {
          double latitude = data.areas[i].latlng[j][k][1];
          double longitude = data.areas[i].latlng[j][k][0];
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
                            site: "region",
                            id: i.toString(),
                          )));
            },
          ),
        );
      }
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
    // _setMarker();
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

    var loc;
    try {
      loc = await Geolocator.getCurrentPosition();
    } catch (_) {
      showDialog(
        context: context,
        builder: (context) {
          return PermissionDialog();
        },
      );
    }
    print(loc);
    LocationData locationData = LocationData.fromMap(
        {"latitude": loc.latitude, "longitude": loc.longitude});
    currentUser.updateLocation(locationData);
    Provider.of<MapDataProvider>(context, listen: false)
        .setLocation(locationData);

    _locationData = locationData;

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

  // _handleTap(LatLng tappedPoint) {
  //   _markers.clear();
  //   setState(() {
  //     _markers.add(
  //       Marker(
  //         markerId: MarkerId(tappedPoint.toString()),
  //         position: tappedPoint,
  //         onTap: () {},
  //       ),
  //     );
  //   });
  // }

  @override
  void initState() {
    super.initState();
    currentUser = Provider.of<CurrentUser>(context, listen: false);
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
              currentUser.updateLocation(_locationData);
              Provider.of<MapDataProvider>(context, listen: false)
                  .setLocation(_locationData);
            });
          },
          markers: _markers,
          circles: _circle,
          polygons: _polygons,
          buildingsEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onCameraMove: (CameraPosition cameraPosition) {
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
        // FloatingActionButton(
        //   onPressed: () => print(
        //       Provider.of<MapDataProvider>(context, listen: false)
        //           .findLocation()),
        //   heroTag: "findlocation",
        // ),
        // Container(
        //   margin: const EdgeInsets.only(top: 60.0),
        //   child: FloatingActionButton(
        //     onPressed: () => print(
        //         Provider.of<MapDataProvider>(context, listen: false)
        //             .findRegion()),
        //     heroTag: "findregion",
        //   ),
        // ),
      ],
    );
  }
}
