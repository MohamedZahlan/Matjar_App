import 'package:flutter_projects/models/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterChangePasswordModeState extends RegisterStates {}

class RegisterGetDataSuccessState extends RegisterStates {
  final LoginModel loginModel;

  RegisterGetDataSuccessState(this.loginModel);
}

class RegisterLoadingDataState extends RegisterStates {}

class RegisterGetDataErrorState extends RegisterStates {
  final error;
  final LoginModel registerModel;

  RegisterGetDataErrorState(this.error, this.registerModel);
}
