
import 'package:get_it/get_it.dart';

import '../../data/datasources/remote_datasource/categories_remote_datasource.dart';
import '../../data/datasources/remote_datasource/chat_remote_data_source.dart';
import '../../data/datasources/remote_datasource/cities_and_countries_remote_datasource.dart';
import '../../data/datasources/remote_datasource/laborers_services_remote_datasource.dart';
import '../../data/datasources/remote_datasource/multi_lang_remote_data_source.dart';
import '../../data/datasources/remote_datasource/packages_remote_data_source.dart';
import '../../data/datasources/remote_datasource/products_remote_datasource.dart';
import '../../data/datasources/remote_datasource/profile_remote_datasource.dart';
import '../../data/datasources/remote_datasource/requests_remote_datasource.dart';
import '../../data/datasources/remote_datasource/services_remote_data_source.dart';
import '../../data/datasources/remote_datasource/stores_services_datasource.dart';
import '../../data/datasources/remote_datasource/vet_services_remote_datasource.dart';
import '../../data/datasources/remote_datasource/auth_remote_datasource.dart';
import '../network/dio_helper.dart';


final sl = GetIt.instance;

class ServicesLocator {
  void init() {

    ///DATA SOURCE
    sl.registerLazySingleton(() => AuthRemoteDataSource(dioHelper:sl(),),);
    sl.registerLazySingleton(() => ChatRemoteDataSource(dioHelper:sl(),),);
    sl.registerLazySingleton(() => ProfileRemoteDatasource(dioHelper:sl(),),);
    sl.registerLazySingleton(() => CategoriesRemoteDatasource(dioHelper:sl(),),);
    sl.registerLazySingleton(() => RequestsRemoteDatasource(dioHelper:sl(),),);
    sl.registerLazySingleton(() => ProductsRemoteDatasource(dioHelper:sl(),),);
    sl.registerLazySingleton(() => LaborersRemoteDatasource(dioHelper:sl(),),);
    sl.registerLazySingleton(() => VetServicesRemoteDatasource(dioHelper:sl(),),);
    sl.registerLazySingleton(() => StoresServicesRemoteDatasource(dioHelper:sl(),),);
    sl.registerLazySingleton(() => CitiesAndCountriesRemoteDatasource(dioHelper:sl(),),);
    sl.registerLazySingleton(() => ServicesRemoteDataSource(dioHelper:sl(),),);
    sl.registerLazySingleton(() => MultiLangRemoteDataSource(dioHelper:sl(),),);
    sl.registerLazySingleton(() => PackagesRemoteDataSource(dioHelper:sl(),),);
    /// API Methods Class (DIO)
    sl.registerLazySingleton(() => DioHelper());
  }
}
