import 'dart:async';

import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gicc/widgets/qiblascreen_widgets/loading_error.dart';
import 'package:gicc/widgets/qiblascreen_widgets/loading_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class QiblahCompass extends StatefulWidget {
  const QiblahCompass({super.key});

  @override
  QiblahCompassState createState() => QiblahCompassState();
}

class QiblahCompassState extends State<QiblahCompass> {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();

  Stream<LocationStatus> get stream => _locationStreamController.stream;
  // bool _isCalibrated = true;

  @override
  void initState() {
    super.initState();
    _checkLocationStatus();
    // _checkCalibration();
  }

  @override
  void dispose() {
    _locationStreamController.close();
    FlutterQiblah().dispose();
    super.dispose();
  }

  // Future<void> _checkCalibration() async {
  //   FlutterCompass.events!.listen((event) {
  //     if (event.accuracy == 0) {
  //       log('This si tghe direction ${event.accuracy}');
  //       if (_isCalibrated) {
  //         setState(() {
  //           _isCalibrated = false;
  //         });
  //         _showCalibrationDialog();
  //       }
  //     } else {
  //       if (!_isCalibrated) {
  //         setState(() {
  //           _isCalibrated = true;
  //         });
  //         log('This si tghe direction ${event.accuracy}');
  //         Navigator.of(context).pop();
  //       }
  //     }
  //   });
  // }

  // void _showCalibrationDialog() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Calibration Needed'),
  //         content: const Text(
  //             'Please perform the figure-eight motion with your device to calibrate the compass.'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();

  //               _showCalibrationDialog(); // Show the dialog again if dismissed
  //             },
  //             child: const Text('Retry'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }
          if (snapshot.data!.enabled == true) {
            switch (snapshot.data!.status) {
              case LocationPermission.always:
              case LocationPermission.whileInUse:
                return const QiblahCompassWidget();

              case LocationPermission.denied:
                return LocationErrorWidget(
                  error: "Location service permission denied",
                  callback: _checkLocationStatus,
                );
              case LocationPermission.deniedForever:
                return LocationErrorWidget(
                  error: "Location service Denied Forever !",
                  callback: _checkLocationStatus,
                );
              // case GeolocationStatus.unknown:
              case LocationPermission.unableToDetermine:
                return LocationErrorWidget(
                  error: "Unknown Location service error",
                  callback: _checkLocationStatus,
                );

              default:
                return const SizedBox();
            }
          } else {
            return LocationErrorWidget(
              error: "Please enable Location service",
              callback: _checkLocationStatus,
            );
          }
        },
      ),
    );
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else {
      _locationStreamController.sink.add(locationStatus);
    }
  }
}

class QiblahCompassWidget extends StatefulWidget {
  const QiblahCompassWidget({super.key});

  @override
  QiblahCompassWidgetState createState() => QiblahCompassWidgetState();
}

class QiblahCompassWidgetState extends State<QiblahCompassWidget>
    with SingleTickerProviderStateMixin {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();
  late AnimationController _animationController;
  Animation<double>? _animation;
  double _begin = 0.0;
  Color _buttonColor = Colors.green;

  Stream<LocationStatus> get stream => _locationStreamController.stream;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 0.0).animate(_animationController);
    _checkLocationStatus();
  }

  @override
  void dispose() {
    _locationStreamController.close();
    FlutterQiblah().dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else {
      _locationStreamController.sink.add(locationStatus);
    }
  }

  void _updateButtonColor(int difference) {
    setState(() {
      if (difference == 0) {
        _buttonColor = const Color(0xFF005015);
      } else if (difference > 0 && difference <= 10) {
        _buttonColor = Colors.yellow;
      } else {
        _buttonColor = Colors.deepOrange;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder(
        stream: FlutterQiblah.qiblahStream,
        builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }

          final qiblahDirection = snapshot.data!;
          final angle = qiblahDirection.qiblah * (pi / 180) * -1;
          final directionInt = qiblahDirection.direction.toInt();
          final offsetInt = qiblahDirection.offset.toInt();
          _animation =
              Tween(begin: _begin, end: angle).animate(_animationController);
          _begin = angle;
          _animationController.forward(from: 0);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _updateButtonColor((directionInt - offsetInt).abs());
          });

          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 90,
                bottom: 90,
                child: Text(
                  "${qiblahDirection.direction.toInt()}°",
                  style: GoogleFonts.aBeeZee(
                      color: const Color(0xFF005015),
                      fontSize: 24,
                      fontWeight: FontWeight.w900),
                ),
              ),
              Transform.rotate(
                angle: (qiblahDirection.direction * (pi / 180) * -1),
                child: SvgPicture.asset('assets/images/compass.svg'),
              ),
              AnimatedBuilder(
                animation: _animation!,
                builder: (context, child) => Transform.rotate(
                  angle: _animation!.value,
                  child: SvgPicture.asset(
                    'assets/images/needle.svg',
                    fit: BoxFit.contain,
                    height: 300,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _buttonColor, // Use the updated button color
                  ),
                  child: Text(
                    'Calibrate to ${qiblahDirection.offset.toInt()}°',
                    style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// class QiblahCompassWidget extends StatefulWidget {
//   const QiblahCompassWidget({super.key});

//   @override
//   State<QiblahCompassWidget> createState() => _QiblahCompassWidgetState();
// }

// class _QiblahCompassWidgetState extends State<QiblahCompassWidget> {
//   final _compassSvg = SvgPicture.asset('assets/images/compass.svg');

//   final _needleSvg = SvgPicture.asset(
//     'assets/images/needle.svg',
//     fit: BoxFit.contain,
//     height: 300,
//     alignment: Alignment.center,
//   );

//   Color _buttonColor = Colors.green;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FlutterQiblah.qiblahStream,
//       builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const LoadingIndicator();
//         }

//         final qiblahDirection = snapshot.data!;

//         final angle = qiblahDirection.qiblah * (pi / 180) * -1;
//         // (qiblahDirection.qiblah - qiblahDirection.direction).abs();

//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           log('$angle');
//           _updateButtonColor(angle);
//         });

//         return Stack(
//           alignment: Alignment.center,
//           children: <Widget>[
//             Transform.rotate(
//               angle: (qiblahDirection.direction * (pi / 180) * -1),
//               child: _compassSvg,
//             ),
//             Transform.rotate(
//               angle: (qiblahDirection.qiblah * (pi / 180) * -1),
//               alignment: Alignment.center,
//               child: _needleSvg,
//             ),
//             Positioned(
//               bottom: 40,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor:
//                       _buttonColor, // Set button color based on the difference
//                 ),
//                 child: const Text('Calibrate'),
//               ),
//             ),
//             Positioned(
//               bottom: 8,
//               child: Text("${qiblahDirection.offset.toStringAsFixed(3)}°"),
//             )
//           ],
//         );
//       },
//     );
//   }

//   void _updateButtonColor(double difference) {
//     setState(() {
//       if (difference < 10) {
//         _buttonColor = Colors.green;
//       } else if (difference < 20) {
//         _buttonColor = Colors.yellow;
//       } else {
//         _buttonColor = Colors.red;
//       }
//     });
//   }
// }