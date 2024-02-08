import 'package:anam/core/network/dio_helper.dart';
import 'package:anam/core/network/error_message_model.dart';
import 'package:dio/dio.dart';

import '../../core/error/error_exception.dart';
import '../../core/network/api_end_points.dart';

abstract class BaseMapRemoteDataSource {
}

class MapRemoteDataSource extends BaseMapRemoteDataSource {
  final DioHelper dioHelper;

  MapRemoteDataSource({required this.dioHelper});


}
