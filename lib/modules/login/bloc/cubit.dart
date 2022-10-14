import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/models/login_model.dart';
import 'package:flutter_projects/modules/login/bloc/states.dart';
import 'package:flutter_projects/shared/end_points.dart';

import '../../../shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPasswordShow = true;

  void changePasswordMode() {
    isPasswordShow = !isPasswordShow;
    emit(LoginChangePasswordModeState());
  }

  LoginModel? loginModel;
  void getUserData({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingDataState());
    await Dio_Helper.postData(
      url: LOGIN,
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginGetDataSuccessState(loginModel!));
    }).catchError((error) {
      print('error here ${error.toString()}');
      emit(LoginGetDataErrorState(error.toString()));
    });
  }
}
