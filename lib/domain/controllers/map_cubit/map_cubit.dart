import 'dart:async';

import 'package:anam/core/base_use_case/base_use_case.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import '../../../core/assets_path/images_path.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  static MapCubit get(context) => BlocProvider.of(context);

  List<Marker> markers = [];
  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;

  void getDataOnMap()async{
    
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
  void getCurrentMarker() async{
    final Uint8List markerIcon = await getBytesFromAsset(ImagesPath.mapMarkerIcon, 100.w.toInt());
    currentIcon = BitmapDescriptor.fromBytes(markerIcon);
    emit(MarkerGenerationDone());
    getMarkers();
  }
  double addedPosition = 0.0105;
  void getMarkers() {

  }

  void handleLogout() {
    emit(MapInitial());
  }

  @override
  Future<void> close() {
    handleLogout();
    return super.close();
  }
}
