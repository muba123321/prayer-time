import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gicc/widgets/qiblascreen_widgets/loading_error.dart';
import 'package:gicc/widgets/qiblascreen_widgets/loading_indicator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class QiblahMaps extends StatefulWidget {
//   static const meccaLatLong = LatLng(21.422487, 39.826206);
//   static final meccaMarker = Marker(
//     markerId: const MarkerId("mecca"),
//     position: meccaLatLong,
//     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
//     draggable: false,
//   );

//   const QiblahMaps({super.key});

//   @override
//   QiblahMapsState createState() => QiblahMapsState();
// }

// class QiblahMapsState extends State<QiblahMaps> {
//   final Completer<GoogleMapController> _controller = Completer();
//   LatLng position = const LatLng(36.800636, 10.180358);

//   late final _future = _checkLocationStatus();
//   final _positionStream = StreamController<LatLng>.broadcast();

//   @override
//   void dispose() {
//     _positionStream.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: FutureBuilder(
//         future: _future,
//         builder: (_, AsyncSnapshot<Position?> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const LoadingIndicator();
//           }
//           if (snapshot.hasError) {
//             return LocationErrorWidget(
//               error: snapshot.error.toString(),
//             );
//           }

//           if (snapshot.data != null) {
//             final loc =
//                 LatLng(snapshot.data!.latitude, snapshot.data!.longitude);
//             position = loc;
//           } else {
//             _positionStream.sink.add(position);
//           }

//           return StreamBuilder(
//             stream: _positionStream.stream,
//             builder: (_, AsyncSnapshot<LatLng> snapshot) => GoogleMap(
//               mapType: MapType.normal,
//               zoomGesturesEnabled: true,
//               compassEnabled: true,
//               myLocationEnabled: true,
//               myLocationButtonEnabled: true,
//               initialCameraPosition: CameraPosition(
//                 target: position,
//                 zoom: 11,
//               ),
//               markers: <Marker>{
//                 QiblahMaps.meccaMarker,
//                 Marker(
//                   draggable: true,
//                   markerId: const MarkerId('Marker'),
//                   position: position,
//                   icon: BitmapDescriptor.defaultMarker,
//                   onTap: _updateCamera,
//                   onDragEnd: (LatLng value) {
//                     position = value;
//                     _positionStream.sink.add(value);
//                   },
//                   zIndex: 5,
//                 ),
//               },
//               circles: <Circle>{
//                 Circle(
//                   circleId: const CircleId("Circle"),
//                   radius: 10,
//                   center: position,
//                   fillColor: Theme.of(context).primaryColorLight.withAlpha(100),
//                   strokeWidth: 1,
//                   strokeColor:
//                       Theme.of(context).primaryColorDark.withAlpha(100),
//                   zIndex: 3,
//                 )
//               },
//               polylines: <Polyline>{
//                 Polyline(
//                   polylineId: const PolylineId("Line"),
//                   points: [position, QiblahMaps.meccaLatLong],
//                   color: Theme.of(context).primaryColor,
//                   width: 5,
//                   zIndex: 4,
//                   geodesic: true,
//                 )
//               },
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<Position?> _checkLocationStatus() async {
//     final locationStatus = await FlutterQiblah.checkLocationStatus();
//     if (locationStatus.enabled) {
//       return await Geolocator.getCurrentPosition();
//     }
//     return null;
//   }

//   void _updateCamera() async {
//     final controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newLatLngZoom(position, 20));
//   }
// }

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class QiblahMaps extends StatefulWidget {
  static const meccaLatLong = LatLng(21.422487, 39.826206);
  static const meccaMarker = Marker(
    width: 80.0,
    height: 80.0,
    point: meccaLatLong, child: Icon(Icons.location_on, color: Colors.red),
    // builder: (ctx) => Container(
    //   child: Icon(Icons.location_on, color: Colors.red),
    // ),
    // child: null,
  );

  const QiblahMaps({super.key});

  @override
  QiblahMapsState createState() => QiblahMapsState();
}

class QiblahMapsState extends State<QiblahMaps> {
  LatLng position = const LatLng(36.800636, 10.180358);

  late final Future<Position?> _future;
  final _positionStream = StreamController<LatLng>.broadcast();

  @override
  void initState() {
    super.initState();
    _future = _checkLocationStatus();
  }

  @override
  void dispose() {
    _positionStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 8, right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FutureBuilder(
          future: _future,
          builder: (_, AsyncSnapshot<Position?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            }
            if (snapshot.hasError) {
              return LocationErrorWidget(
                error: snapshot.error.toString(),
              );
            }

            if (snapshot.data != null) {
              final loc =
                  LatLng(snapshot.data!.latitude, snapshot.data!.longitude);
              position = loc;
            } else {
              _positionStream.sink.add(position);
            }

            return StreamBuilder(
              stream: _positionStream.stream,
              builder: (_, AsyncSnapshot<LatLng> snapshot) => FlutterMap(
                options: MapOptions(
                  initialCenter: position,
                  initialZoom: 11.0,
                  onTap: (tapPosition, point) => _updateCamera,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.gicc',
                    // Plenty of other options available!
                  ),
                  const SimpleAttributionWidget(
                    source: Text('OpenStreetMap contributors'),
                  ),
                  MarkerLayer(
                    markers: [
                      QiblahMaps.meccaMarker,
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: position,
                        child:
                            const Icon(Icons.location_on, color: Colors.blue),
                      ),
                    ],
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: [position, QiblahMaps.meccaLatLong],
                        color: Theme.of(context).primaryColor,
                        strokeWidth: 4.0,
                      ),
                    ],
                  ),
                  CircleLayer(
                    circles: [
                      CircleMarker(
                        point: position,
                        color:
                            Theme.of(context).primaryColorLight.withAlpha(100),
                        radius: 10.0,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<Position?> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled) {
      return await Geolocator.getCurrentPosition();
    }
    return null;
  }

  void _updateCamera(LatLng latLng) {
    setState(() {
      position = latLng;
      _positionStream.sink.add(latLng);
    });
  }
}
