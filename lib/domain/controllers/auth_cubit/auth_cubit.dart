import 'package:anam/core/cache_helper/cache_keys.dart';
import 'package:anam/core/cache_helper/shared_pref_methods.dart';
import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/network/error_message_model.dart';
import 'package:anam/core/parameters/register_parameters.dart';
import 'package:anam/data/datasources/remote_datasource/auth_remote_datasource.dart';
import 'package:anam/data/models/auth_models/login_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/services_locator.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  final AuthRemoteDataSource authRemoteDataSource = sl();
  LoginAndRegisterModel? loginAndRegisterModel;
  BaseErrorModel? baseErrorModel;

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
            error: baseErrorModel?.errors?[0] ?? "",
          ),
        );
      },
      (r) {
        loginAndRegisterModel = r;
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
        token = CacheHelper.getData(
          key: CacheKeys.token,
        );
        emit(RegisterSuccessState());
      },
    );
  }
}
