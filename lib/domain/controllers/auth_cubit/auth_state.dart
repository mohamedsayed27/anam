
abstract class AuthState {}

class AuthInitial extends AuthState {}

class RegisterLoadingState extends AuthState {}
class RegisterSuccessState extends AuthState {}
class RegisterErrorState extends AuthState {
  final String error;
  RegisterErrorState({required this.error});
}

class LoginLoadingState extends AuthState {}
class LoginSuccessState extends AuthState {}
class LoginErrorState extends AuthState {
  final String error;
  LoginErrorState({required this.error});
}
