import 'dart:io';

import 'package:anam/core/cache_helper/cache_keys.dart';
import 'package:anam/core/cache_helper/shared_pref_methods.dart';
import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/network/error_message_model.dart';
import 'package:anam/core/parameters/register_parameters.dart';
import 'package:anam/data/datasources/remote_datasource/auth_remote_datasource.dart';
import 'package:anam/data/models/auth_models/login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/services/services_locator.dart';
import '../../../data/datasources/remote_datasource/cities_and_countries_remote_datasource.dart';
import '../../../data/models/country_model/country_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  final AuthRemoteDataSource authRemoteDataSource = sl();
  final CitiesAndCountriesRemoteDatasource citiesAndCountriesRemoteDatasource =
      sl();
  LoginAndRegisterModel? loginAndRegisterModel;
  BaseErrorModel? baseErrorModel;
  String? selectedRole;
  List<CountryModel> countriesList = [];
  CountryModel? chosenCity;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController loginEmailController = TextEditingController();

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
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message,
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
          key: CacheKeys.userName,
          value: r.loginAndRegisterDataModel!.user!.name.toString(),
        );
        await CacheHelper.saveData(
          key: CacheKeys.userEmail,
          value: r.loginAndRegisterDataModel!.user!.email.toString(),
        );
        await CacheHelper.saveData(
          key: CacheKeys.phone,
          value: r.loginAndRegisterDataModel!.user!.phone.toString(),
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

  void socialLogin({
    required String email,
    required String socialId,
    required String name,
    required String socialType,
    required String userType,
  }) async {
    emit(SocialLoginLoadingState());
    final response = await authRemoteDataSource.authLogin(
      email: email,
      socialId: socialId,
      name: name,
      socialType: socialType,
      userType: userType,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        print(l.baseErrorModel);
        emit(SocialLoginErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message,
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
          value: r.loginAndRegisterDataModel!.user!.id,
        );
        await CacheHelper.saveData(
          key: CacheKeys.userType,
          value: r.loginAndRegisterDataModel!.user!.type,
        );
        await CacheHelper.saveData(
          key: CacheKeys.userName,
          value: r.loginAndRegisterDataModel!.user!.name.toString(),
        );
        await CacheHelper.saveData(
          key: CacheKeys.userEmail,
          value: r.loginAndRegisterDataModel!.user!.email.toString(),
        );
        await CacheHelper.saveData(
          key: CacheKeys.phone,
          value: r.loginAndRegisterDataModel!.user!.phone.toString(),
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
        emit(SocialLoginSuccessState());
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
          key: CacheKeys.userName,
          value: r.loginAndRegisterDataModel!.user!.name.toString(),
        );
        await CacheHelper.saveData(
          key: CacheKeys.userEmail,
          value: r.loginAndRegisterDataModel!.user!.email.toString(),
        );
        await CacheHelper.saveData(
          key: CacheKeys.phone,
          value: r.loginAndRegisterDataModel!.user!.phone.toString(),
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

  void changeRegisterType(String? value) {
    selectedRole = value;
    emit(ChangeRoleState());
  }

  void changeCity(CountryModel? value) {
    chosenCity = value;
    print(chosenCity);
    emit(ChangeCityState());
  }

  List<String> scopes = [
    'email',
    'profile',
  ];

  Future<void> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: Platform.isIOS ? googleClientIdIos : googleClientIdAndroid,
      scopes: scopes,
    );
    try {
      final response = await googleSignIn.signIn();
      socialLogin(
        email: response?.email ?? "",
        socialId: response?.id ?? "",
        name: response?.displayName ?? "",
        socialType: "google",
        userType: selectedRole ?? "",
      );
      print(response);
    } catch (error) {
      print(error);
    }
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
