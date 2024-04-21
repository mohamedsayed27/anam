import 'package:anam/core/network/error_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../data/datasources/remote_datasource/packages_remote_data_source.dart';
import '../../../data/models/packages_model/packages_model.dart';

part 'packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  PackagesCubit() : super(PackagesInitial());
  static PackagesCubit get(context) => BlocProvider.of(context);
  final PackagesRemoteDataSource _packagesRemoteDataSource = sl();
  BaseErrorModel? baseErrorModel;
  List<MonthlyPackage>? monthlyPackage = [];
  void getAllProducts() async {
    emit(GetAllPackagesLoadingState());
    final response = await _packagesRemoteDataSource.getAllPackages();
    response.fold(
          (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetAllPackagesErrorState(error: baseErrorModel?.message ?? ""));
      },
          (r) {
            monthlyPackage = r.monthlyPackage;
            print(r.monthlyPackage);
          emit(GetAllPackagesSuccessState());
        }
    );
  }
}
