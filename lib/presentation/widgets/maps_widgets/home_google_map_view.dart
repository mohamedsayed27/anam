import 'dart:async';

import '../../../../domain/controllers/map_cubit/map_state.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import '../../../core/assets_path/images_path.dart';
import '../../../../domain/controllers/map_cubit/map_cubit.dart';
import 'info_window_widget.dart';

class HomeGoogleMapsView extends StatefulWidget {
  const HomeGoogleMapsView({super.key});

  @override
  State<HomeGoogleMapsView> createState() => _HomeGoogleMapsViewState();
}

class _HomeGoogleMapsViewState extends State<HomeGoogleMapsView> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      builder: (context, state) {
        return false
            ? Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(23.61108120291162, 45.286281856525534),
                      zoom: 11.5,
                    ),
                    onMapCreated: (controller) {
                      // cubit.googleMapController.complete(controller);
                      // cubit.customInfoWindowController.googleMapController =
                      //     controller;
                    },
                    onCameraMove: (position) {
                      // cubit.customInfoWindowController.onCameraMove!();
                    },
                    onTap: (latLng) {
                      // cubit.customInfoWindowController.hideInfoWindow!();
                    },
                    gestureRecognizers: {
                      Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer())
                    },
                    // markers: Set.of(cubit.markers),
                  ),
                  // CustomInfoWindow(
                  //   // controller: cubit.customInfoWindowController,
                  //   width: 255.w,
                  //   height: 230.h,
                  //   offset: 30.h,
                  // )
                ],
              )
            : const Center(
                child: CircularProgressIndicator.adaptive(),
              );
      },
      listener: (context, state) {},
    );
  }
}
