import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../network/error_message_model.dart';

class ErrorException extends Equatable implements Exception{
  final BaseErrorModel baseErrorModel;

  const ErrorException({required this.baseErrorModel});
  @override
  // TODO: implement props
  List<Object?> get props => [
    baseErrorModel,
  ];

}