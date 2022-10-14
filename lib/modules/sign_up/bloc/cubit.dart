import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/models/login_model.dart';
import 'package:flutter_projects/modules/login/bloc/states.dart';
import 'package:flutter_projects/modules/sign_up/bloc/states.dart';
import 'package:flutter_projects/shared/end_points.dart';

import '../../../shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPasswordShow = true;

  void changePasswordMode() {
    isPasswordShow = !isPasswordShow;
    emit(RegisterChangePasswordModeState());
  }

  LoginModel? loginModel;
  void postUserData({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(RegisterLoadingDataState());
    Dio_Helper.postData(
      url: REGEISTER,
      data: {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
      },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterGetDataSuccessState(loginModel!));
    }).catchError((error) {
      print('error here ${error.toString()}');
      emit(RegisterGetDataErrorState(error.toString(), loginModel!));
    });
  }
}
