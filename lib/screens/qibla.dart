// lib/screens/qibla_screen.dart

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:gicc/widgets/qiblascreen_widgets/loading_indicator.dart';
import 'package:gicc/widgets/qiblascreen_widgets/qiblah_compass.dart';
import 'package:gicc/widgets/qiblascreen_widgets/qiblah_map.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:gicc/core/theme/design_system.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  QiblaScreenState createState() => QiblaScreenState();
}

class QiblaScreenState extends State<QiblaScreen> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
  bool _showCompass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
        future: _deviceSupport,
        builder: (_, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );
          }

          if (snapshot.data!) {
            log('This is main qibla page${snapshot.data.toString()}');
            return Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                _showCompass ? const QiblahCompass() : const QiblahMaps(),
                Positioned(
                  top: 24.0,
                  right: 50,
                  left: 50,
                  child: AnimatedToggleSwitch<bool>.dual(
                    current: _showCompass,
                    first: false,
                    second: true,
                    borderWidth: 3.0,
                    height: 60,
                    indicatorSize: const Size.fromWidth(110),
                    style: ToggleStyle(
                      borderColor: Colors.transparent,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.borderRadiusLg),
                      backgroundColor: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowMedium,
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    onChanged: (b) => setState(() => _showCompass = b),
                    styleBuilder: (i) => ToggleStyle(
                      indicatorColor:
                          i ? AppColors.secondary : AppColors.primary,
                    ),
                    iconBuilder: (value) => value
                        ? const Icon(
                            FlutterIslamicIcons.qibla,
                            color: Colors.white,
                            size: 28,
                          )
                        : const Icon(
                            FlutterIslamicIcons.kaaba,
                            color: Colors.white,
                            size: 28,
                          ),
                    textBuilder: (value) => Center(
                      child: Text(
                        value ? 'Compass' : 'Map',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Device does not support the sensor"),
            );
          }
        },
      ),
    );
  }
}
