import 'package:flutter_projects/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginChangePasswordModeState extends LoginStates {}

class LoginGetDataSuccessState extends LoginStates {
  final LoginModel loginModel;

  LoginGetDataSuccessState(this.loginModel);
}

class LoginLoadingDataState extends LoginStates {}

class LoginGetDataErrorState extends LoginStates {
  final error;

  LoginGetDataErrorState(this.error);
}
