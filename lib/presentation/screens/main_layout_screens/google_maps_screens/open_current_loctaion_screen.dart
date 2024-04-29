import 'package:anam/core/app_theme/custom_themes.dart';
import 'package:anam/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationOnMapScreen extends StatelessWidget {
  final LatLng initialLocation;

  const LocationOnMapScreen({Key? key, required this.initialLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.locationOnMap.tr(),
          style: CustomThemes.darkGreyColorTextTheme(context).copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 12.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('Marker'),
            position: initialLocation,
          ),
        },
      ),
    );
  }
}
