import 'dart:async';
import 'dart:developer';

import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gicc/widgets/qiblascreen_widgets/loading_error.dart';
import 'package:gicc/widgets/qiblascreen_widgets/loading_indicator.dart';
import 'package:gicc/core/theme/design_system.dart';
import 'package:permission_handler/permission_handler.dart';

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

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    log('Checking location status');
    log('Location status: ${locationStatus.enabled}, ${locationStatus.status}');
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      log('Requesting permissions');
      log('This is the status ${locationStatus.status}');
      log('This is the enabled ${locationStatus.enabled}');
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.deniedForever) {
    } else {
      _locationStreamController.sink.add(locationStatus);
    }
  }

  void openSettings() async {
    bool opened = await openAppSettings();
    if (opened) {
      _checkLocationStatus();
    }
  }

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
                  callback: openSettings,
                );
              case LocationPermission.deniedForever:
                return LocationErrorWidget(
                  error:
                      "Location service Denied Forever. Click retry to edit!",
                  callback: _checkLocationStatus,
                );
              // case GeolocationStatus.unknown:
              case LocationPermission.unableToDetermine:
                return LocationErrorWidget(
                  error: "Unknown Location service error",
                  callback: _checkLocationStatus,
                );
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

  // Future<void> _checkLocationStatus() async {
  //   try {
  //     log('Checking location status');
  //     final locationStatus = await FlutterQiblah.checkLocationStatus();
  //     log('Location status: ${locationStatus.enabled}, ${locationStatus.status}');

  //     if (locationStatus.enabled &&
  //         locationStatus.status == LocationPermission.denied) {
  //       log('Requesting permissions');
  //       await FlutterQiblah.requestPermissions();
  //       final s = await FlutterQiblah.checkLocationStatus();
  //       log('Updated location status after requesting permissions: ${s.enabled}, ${s.status}');
  //       _locationStreamController.sink.add(s);
  //     } else {
  //       log('Adding location status to stream');
  //       _locationStreamController.sink.add(locationStatus);
  //     }
  //   } catch (e) {
  //     log('Error checking location status: $e');
  //   }
  // }
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
          final differenceAbs = (directionInt - offsetInt).abs();

          _animation =
              Tween(begin: _begin, end: angle).animate(_animationController);
          _begin = angle;
          _animationController.forward(from: 0);

          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // Instructions card at the top
              Positioned(
                top: 60,
                left: 24,
                right: 24,
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.95),
                        AppColors.primaryLight.withValues(alpha: 0.95),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(AppSpacing.borderRadiusLg),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.explore,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            "${qiblahDirection.direction.toInt()}°",
                            style: AppTextStyles.headlineSmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        differenceAbs == 0
                            ? "Perfect! Facing Qibla"
                            : "Hold flat & rotate ${qiblahDirection.offset.toInt()}°",
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white.withValues(alpha: 0.95),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              // Compass background with animation
              Transform.rotate(
                angle: (qiblahDirection.direction * (pi / 180) * -1),
                child: SvgPicture.asset('assets/images/compass.svg'),
              ),

              // Animated needle
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

              // Distance/Direction indicator at bottom
              Positioned(
                bottom: 120,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius:
                        BorderRadius.circular(AppSpacing.borderRadiusLg),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        differenceAbs <= 5
                            ? Icons.check_circle
                            : differenceAbs <= 15
                                ? Icons.adjust
                                : Icons.rotate_right,
                        color: differenceAbs <= 5
                            ? Colors.green
                            : differenceAbs <= 15
                                ? Colors.orange
                                : AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        differenceAbs <= 5
                            ? "Accurate"
                            : differenceAbs <= 15
                                ? "Close"
                                : "Keep Rotating",
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Calibration help button
              Positioned(
                bottom: 40,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      _showCalibrationDialog(context);
                    },
                    borderRadius:
                        BorderRadius.circular(AppSpacing.borderRadiusLg),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.md,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: differenceAbs == 0
                              ? [
                                  const Color(0xFF10B981),
                                  const Color(0xFF059669),
                                ]
                              : [
                                  AppColors.primary,
                                  AppColors.primaryLight,
                                ],
                        ),
                        borderRadius:
                            BorderRadius.circular(AppSpacing.borderRadiusLg),
                        boxShadow: [
                          BoxShadow(
                            color: (differenceAbs == 0
                                    ? Colors.green
                                    : AppColors.primary)
                                .withValues(alpha: 0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            differenceAbs == 0
                                ? Icons.done_all_rounded
                                : Icons.help_outline_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            differenceAbs == 0
                                ? 'Aligned with Qibla!'
                                : 'Need Help?',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showCalibrationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLg),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.help_outline,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'How to Use Compass',
                  style: AppTextStyles.titleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInstructionItem(
                  '1',
                  'Hold Device Flat',
                  'Keep your phone parallel to the ground (screen facing up)',
                  Icons.phone_android,
                ),
                const SizedBox(height: 16),
                _buildInstructionItem(
                  '2',
                  'Calibrate Compass',
                  'Move your phone in a figure-8 motion for better accuracy',
                  Icons.all_inclusive,
                ),
                const SizedBox(height: 16),
                _buildInstructionItem(
                  '3',
                  'Rotate Your Body',
                  'Turn yourself (not just the phone) until the needle points to 0°',
                  Icons.rotate_right,
                ),
                const SizedBox(height: 16),
                _buildInstructionItem(
                  '4',
                  'Face Qibla',
                  'When aligned, you\'re facing the direction of prayer',
                  Icons.done_all,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Got it!',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInstructionItem(
      String number, String title, String description, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.primaryLight],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 18, color: AppColors.primary),
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
