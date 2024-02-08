import 'package:dartz/dartz.dart';
import '../../../core/error/error_exception.dart';
import '../../models/base_model.dart';
abstract class ServicesBaseDatasource<T, S, p> {
  Future<Either<ErrorException, T>> getAll({
    required int pageNumber,
  });

  Future<Either<ErrorException, S>> showSingle({
    required int id,
  });

  Future<Either<ErrorException, T>> getUserFollowing({required int pageNumber});

  Future<Either<ErrorException, BaseResponseModel>> delete({
    required int id,
  });
  Future<Either<ErrorException, S>> upload({
    required p parameters,
  });
  Future<Either<ErrorException, S>> update({
    required p parameters,
  });
}