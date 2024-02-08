import 'package:anam/core/cache_helper/cache_keys.dart';
import 'package:anam/core/cache_helper/shared_pref_methods.dart';
import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/network/error_message_model.dart';
import 'package:anam/core/parameters/register_parameters.dart';
import 'package:anam/data/datasources/remote_datasource/auth_remote_datasource.dart';
import 'package:anam/data/models/auth_models/login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/services_locator.dart';
import '../../../data/datasources/remote_datasource/cities_and_countries_remote_datasource.dart';
import '../../../data/models/country_model/country_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  final AuthRemoteDataSource authRemoteDataSource = sl();
  final CitiesAndCountriesRemoteDatasource citiesAndCountriesRemoteDatasource = sl();
  LoginAndRegisterModel? loginAndRegisterModel;
  BaseErrorModel? baseErrorModel;
  String? selectedRole;
  List<CountryModel> countriesList = [];
  CountryModel? chosenCity;

  final TextEditingController phoneController =TextEditingController();
  final TextEditingController firstNameController =TextEditingController();
  final TextEditingController secondNameController =TextEditingController();
  final TextEditingController passwordController =TextEditingController();
  final TextEditingController loginPasswordController =TextEditingController();
  final TextEditingController confirmPasswordController =TextEditingController();
  final TextEditingController emailController =TextEditingController();
  final TextEditingController loginEmailController =TextEditingController();
  void login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    final response = await authRemoteDataSource.login(
      email: email,
      password: password,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          LoginErrorState(
            error: l.baseErrorModel.errors!=null?baseErrorModel!.errors![0]!:l.baseErrorModel!.message,
          ),
        );
      },
      (r) async{
        loginAndRegisterModel = r;
        await CacheHelper.saveData(
          key: CacheKeys.token,
          value: r.loginAndRegisterDataModel!.token!,
        );
        await CacheHelper.saveData(
          key: CacheKeys.userId,
          value: r.loginAndRegisterDataModel!.user!.id,
        );
        await CacheHelper.saveData(
          key: CacheKeys.userType,
          value: r.loginAndRegisterDataModel!.user!.type,
        );
        token = CacheHelper.getData(
          key: CacheKeys.token,
        );
        userId = CacheHelper.getData(
          key: CacheKeys.userId.toString(),
        ).toString();
        userType = CacheHelper.getData(
          key: CacheKeys.userType.toString(),
        );
        emit(LoginSuccessState());
      },
    );
  }

  void register({
    required RegisterParameters registerParameters,
  }) async {
    emit(RegisterLoadingState());
    final response = await authRemoteDataSource.register(
      parameters: registerParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          RegisterErrorState(
            error: baseErrorModel?.errors?[0] ?? "",
          ),
        );
      },
      (r) async {
        loginAndRegisterModel = r;
        await CacheHelper.saveData(
          key: CacheKeys.token,
          value: r.loginAndRegisterDataModel!.token!,
        );
        await CacheHelper.saveData(
          key: CacheKeys.userId,
          value: r.loginAndRegisterDataModel!.user!.id.toString(),
        );
        await CacheHelper.saveData(
          key: CacheKeys.userType,
          value: r.loginAndRegisterDataModel!.user!.type.toString(),
        );
        token = CacheHelper.getData(
          key: CacheKeys.token,
        );
        userId = CacheHelper.getData(
          key: CacheKeys.userId.toString(),
        );
        userType = CacheHelper.getData(
          key: CacheKeys.userType.toString(),
        );
        emit(RegisterSuccessState());
      },
    );
  }

  void changeRegisterType(String? value){
    selectedRole = value;
    emit(ChangeRoleState());
  }

  void changeCity(CountryModel? value){
    chosenCity = value;
    print(chosenCity);
    emit(ChangeCityState());
  }



  void getAllCountries() async {
    emit(GetAllCountriesLoadingState());
    final response = await citiesAndCountriesRemoteDatasource.getAllCountries();
    response.fold(
          (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetAllCountriesErrorState(error: baseErrorModel?.message ?? ""));
      },
          (r) {
            countriesList.addAll(r.countriesList!);
            print(countriesList);
          emit(GetAllCountriesSuccessState());
      },
    );
  }
  void handleLogout() {
    emit(AuthInitial());
  }

  @override
  Future<void> close() {
    handleLogout();
    return super.close();
  }
}
