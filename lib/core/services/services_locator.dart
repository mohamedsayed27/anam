import 'package:abyaty/core/network/dio_helper.dart';
import 'package:abyaty/data/datasource/remote_datasource/address_datasource.dart';
import 'package:abyaty/data/datasource/remote_datasource/auth_datasource.dart';
import 'package:abyaty/data/datasource/remote_datasource/categories_datasource.dart';
import 'package:abyaty/data/datasource/remote_datasource/profile_datasource.dart';
import 'package:abyaty/data/repository/address_repository/address_repository.dart';
import 'package:abyaty/data/repository/categories_repository/categories_repository.dart';
import 'package:abyaty/data/repository/profile_repository/profile_repository.dart';
import 'package:abyaty/domain/repositories/auth_base_repository/auth_base_repository.dart';
import 'package:abyaty/domain/repositories/categories_base_repository/categories_base_repository.dart';
import 'package:abyaty/domain/repositories/profile_base_repository/profile_base_repository.dart';
import 'package:abyaty/domain/use_cases/address_use_case/delete_address.dart';
import 'package:abyaty/domain/use_cases/address_use_case/get_address_list_use_case.dart';
import 'package:abyaty/domain/use_cases/address_use_case/post_address_use_case.dart';
import 'package:abyaty/domain/use_cases/address_use_case/show_address_use_case.dart';
import 'package:abyaty/domain/use_cases/address_use_case/update_address_use_case.dart';
import 'package:abyaty/domain/use_cases/auth_usecases/login_usecase.dart';
import 'package:abyaty/domain/use_cases/auth_usecases/register_use_case.dart';
import 'package:get_it/get_it.dart';

import '../../data/repository/auth_repository/auth_repository.dart';
import '../../domain/repositories/address_base_repository/address_base_repository.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    ///USE CASES

    /// Auth UseCases
    sl.registerLazySingleton(
      () => LoginUseCase(
        authBaseRepository: sl(),
      )
    );
    sl.registerLazySingleton(
      () => RegisterUseCase(
        authBaseRepository: sl(),
      )
    );
    /// Address UseCases
    sl.registerLazySingleton(
      () => DeleteAddressUseCase(addressBaseRepository: sl()
      )
    );
    sl.registerLazySingleton(
      () => PostAddressUseCase(
        addressBaseRepository:sl(),
      )
    );
    sl.registerLazySingleton(
      () => UpdateAddressUseCase(
        addressBaseRepository:sl(),
      )
    );
    sl.registerLazySingleton(
      () => ShowAddressUseCase(
        addressBaseRepository:sl(),
      )
    );
    sl.registerLazySingleton(
      () => GetAddressListUseCase(
        addressBaseRepository:sl(),
      )
    );

    ///REPOSITORY
    sl.registerLazySingleton<AuthBaseRepository>(() => AuthRepository(authBaseRemoteDataSource: sl()));
    sl.registerLazySingleton<AddressBaseRepository>(() => AddressRepository(addressBaseRemoteDatasource: sl()));
    sl.registerLazySingleton<ProfileBaseRepository>(() => ProfileRepository(profileBaseRemoteDataSource: sl()));
    sl.registerLazySingleton<CategoriesBaseRepository>(() => CategoriesRepository(categoriesBaseRemoteDatasource:sl()));

    ///DATA SOURCE
    sl.registerLazySingleton<AuthBaseRemoteDataSource>(() => AuthRemoteDataSource(dioHelper: sl()));
    sl.registerLazySingleton<AddressBaseRemoteDatasource>(() => AddressRemoteDataSource(dioHelper: sl()));
    sl.registerLazySingleton<ProfileBaseRemoteDataSource>(() => ProfileRemoteDataSource(dioHelper: sl()));
    sl.registerLazySingleton<CategoriesRemoteBaseDatasource>(() => CategoriesRemoteDatasource(dioHelper: sl()));

    /// API Methods Class (DIO)
    sl.registerLazySingleton(() => DioHelper());
  }
}
