import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/cubit.dart';
import 'package:flutter_projects/modules/login/login_screen.dart';
import 'package:flutter_projects/modules/on_boarding/on_boarding.dart';
import 'package:flutter_projects/shared/bloc_observer.dart';
import 'package:flutter_projects/shared/network/local/cache_helper.dart';
import 'package:flutter_projects/shared/network/remote/dio_helper.dart';
import 'package:flutter_projects/shared/network/shared.styles/themes.dart';
import 'package:flutter_projects/shared/shared_components/components.dart';
import 'package:flutter_projects/shared/shared_components/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'Layout/shop_app/shop_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Cache_Helper.init();
  Dio_Helper.init();
  var per = await Geolocator.checkPermission();
  if (per == LocationPermission.denied) {
    per = await Geolocator.requestPermission();
  }
  dynamic onBoarding = false;
  onBoarding = Cache_Helper.getData(key: 'onBoarding');
  token = Cache_Helper.getData(key: 'token');
  await Geolocator.requestPermission();
  print(token);
  late Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }
  runApp(
    Phoenix(
      child: DevicePreview(
        builder: (context) => MyApp(widget),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  Widget start;
  MyApp(
    this.start, {
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getFavData()
        ..getCartData()
        ..getProfileData()
        ..getSettingsData()
        ..getFAQData()
        ..getAddress()
        ..getOrderData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: DevicePreview.appBuilder,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: start,
      ),
    );
  }
}
