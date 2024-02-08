import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/error_exception.dart';


abstract class  BaseUseCase<T,Parameters>{
  Future<Either<ErrorException, T>>call(Parameters parameters);
}
class NoParameters extends Equatable{
  const NoParameters();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}