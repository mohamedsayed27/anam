import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/assets_path/images_path.dart';
import '../../../data/models/products_model/product_model.dart';
import 'info_window_widget.dart';

class HomeGoogleMapsView extends StatefulWidget {
  final List<ProductDataModel> productsList;

  const HomeGoogleMapsView({super.key, required this.productsList});

  @override
  State<HomeGoogleMapsView> createState() => _HomeGoogleMapsViewState();
}

class _HomeGoogleMapsViewState extends State<HomeGoogleMapsView> {
  @override
  void initState() {
    super.initState();
    getCurrentMarker();
  }

  Set<Marker> markers = <Marker>{};
  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();
  final CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;
  bool isLoading = false;
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
  void getCurrentMarker() async{
    setState(() {
      isLoading = true;
    });
    final Uint8List markerIcon = await getBytesFromAsset(ImagesPath.mapMarkerIcon, 100.w.toInt());
    currentIcon = BitmapDescriptor.fromBytes(markerIcon);
    setMarkers();
    setState(() {
      isLoading = false;
    });
  }
  void setMarkers() {

    for (var element in widget.productsList) {
      markers.add(
        Marker(
          markerId: MarkerId("${element.id}"),
          icon: currentIcon,
          position: LatLng(
            double.parse(element.coordinates?.split(",").first ?? "0"),
            double.parse(
                element.coordinates?.split(",").last.trim() ?? "0"),
          ),
          onTap: () {
            customInfoWindowController.addInfoWindow!(
              InfoWindowWidget(
                productDataModel: element,
              ),
              LatLng(
                double.parse(element.coordinates?.split(",").first ?? "0"),
                double.parse(
                    element.coordinates?.split(",").last.trim() ?? "0"),
              ),
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    double.parse(widget.productsList.first.coordinates
                            ?.split(",")
                            .first ??
                        "0"),
                    double.parse(widget.productsList.first.coordinates
                            ?.split(",")
                            .last
                            .trim() ??
                        "0"),
                  ),
                  zoom: 11.5,
                ),
                onMapCreated: (controller) {
                  googleMapController.complete(controller);
                  customInfoWindowController.googleMapController = controller;
                },
                onCameraMove: (position) {
                  customInfoWindowController.onCameraMove!();
                },
                onTap: (latLng) {
                  customInfoWindowController.hideInfoWindow!();
                },
                gestureRecognizers: {
                  Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer())
                },
                markers: markers,
              ),
              CustomInfoWindow(
                controller: customInfoWindowController,
                width: 255.w,
                height: 230.h,
                offset: 30.h,
              )
            ],
          );
  }
}
