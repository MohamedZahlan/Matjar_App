import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/states.dart';
import 'package:flutter_projects/models/HomeModel.dart';
import 'package:flutter_projects/models/add_address.dart';
import 'package:flutter_projects/models/address_model.dart';
import 'package:flutter_projects/models/cart_model.dart';
import 'package:flutter_projects/models/categories_model.dart';
import 'package:flutter_projects/models/changefav.dart';
import 'package:flutter_projects/models/faq_model.dart';
import 'package:flutter_projects/models/favorites_model.dart';
import 'package:flutter_projects/models/get_cart_model.dart';
import 'package:flutter_projects/models/orders_model.dart';
import 'package:flutter_projects/models/product_details_model.dart';
import 'package:flutter_projects/models/settings_model.dart';
import 'package:flutter_projects/modules/categories/categories_screen.dart';
import 'package:flutter_projects/modules/favorites/favorites_screen.dart';
import 'package:flutter_projects/shared/network/local/cache_helper.dart';
import 'package:flutter_projects/shared/shared_components/constants.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/add_order.dart';
import '../../../models/del_address.dart';
import '../../../models/login_model.dart';
import '../../../modules/home_products/products_screen.dart';
import '../../../modules/settings/settings_screen.dart';
import '../../../shared/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];
  List<BottomNavigationBarItem> bottomNav = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined), label: "Home"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.category_outlined), label: "Categories"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: "Favorites"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: "Settings"),
  ];

  final iconData = [
    Icon(Icons.home_outlined),
    Icon(Icons.category_outlined),
    Icon(Icons.favorite),
    Icon(Icons.settings),
  ];

  int currentIndex = 0;

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  Map<int, bool> favorites = {};
  Map<int, bool> inCart = {};

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    Dio_Helper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data?.products.forEach((element) {
        favorites.addAll({
          element.id: element.in_favorites!,
        });
        inCart.addAll({
          element.id: element.in_cart!,
        });
      });
      emit(ShopGetHomeDataSuccessState());
    }).catchError((error) {
      print("error here${error.toString()}");
      emit(ShopGetHomeDataErrorState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(ShopLoadingCategoriesDataState());
    Dio_Helper.getData(
      url: CATEGORIES,
      lang: 'en',
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(value.data);
      emit(ShopGetCategoriesDataSuccessState());
    }).catchError((error) {
      print("error here ${error.toString()}");
      emit(ShopGetCategoriesDataErrorState(error));
    });
  }

  // void getCategoriesDetails(int id) {
  //   emit(ShopLoadingCategoriesDetailsState());
  //   Dio_Helper.getData(url: CATEGORIES + '$id', lang: 'en', token: token)
  //       .then((value) {
  //     categoriesModel = CategoriesModel.fromJson(value.data);
  //     print(value.data);
  //     emit(ShopGetCategoriesDetailsSuccessState());
  //   }).catchError((error) {
  //     print("error here ${error.toString()}");
  //     emit(ShopGetCategoriesDetailsErrorState(error));
  //   });
  // }

  ChangeFavModel? changeFavModel;

  void changeFav(int productID) {
    favorites[productID] = !favorites[productID]!;
    emit(ShopChangFavState());
    Dio_Helper.postData(
      url: FAVORITES,
      data: {
        "product_id": productID,
      },
      token: token,
    ).then((value) {
      changeFavModel = ChangeFavModel.fromJson(value.data);
      print(value.data);
      if (changeFavModel!.status == false) {
        favorites[productID] = !favorites[productID]!;
      } else {
        getFavData();
      }
      emit(ShopChangFavSuccessState(changeFavModel!));
    }).catchError((error) {
      favorites[productID] = !favorites[productID]!;
      emit(ShopChangeFavErrorState(error.toString()));
    });
  }

  FavModel? favModel;

  void getFavData() {
    emit(ShopLoadingFavSuccessState());
    Dio_Helper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favModel = FavModel.fromJson(value.data);
      print(value.data);
      emit(ShopGetFavSuccessState());
    }).catchError((error) {
      print("error here ${error.toString()}");
      emit(ShopGetFavErrorState(error.toString()));
    });
  }

  ProductDetailsModel? productDetailsModel;

  Future getProductDetails(int id) async {
    await Dio_Helper.getData(
      url: PRODUCTSDETAILS + '$id',
      token: token,
    ).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      emit(ShopGetProductDetailsSuccessState());
    }).catchError((error) {
      print("error here ${error.toString()}");
      emit(ShopGetProductDetailsErrorState(error.toString()));
    });
  }

  int activeIndex = 0;

  void changeProductImage(int x) {
    activeIndex = x;
    emit(ShopChangeIndicatorState());
  }

  late CartModel cartModel;

  void changeCartsItem(int productId) {
    if (inCart[productId] == true) {
      inCart[productId] == false;
    } else {
      inCart[productId] == true;
    }
    emit(ShopChangeCartState());
    Dio_Helper.postData(
      url: CARTS,
      data: {
        "product_id": productId,
      },
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      print(value.data);
      if (cartModel.status!) {
        inCart[productId] = !inCart[productId]!;
      } else {
        getCartData();
      }
      getCartData();
      emit(ShopChangeCartSuccessState(cartModel));
    }).catchError((error) {
      if (inCart[productId] == true) {
        inCart[productId] == false;
      } else {
        inCart[productId] == true;
      }
      print("error here ${error.toString()}");
      emit(ShopChangeCartErrorState(error.toString()));
    });
  }

  GetCartModel? getCartModel;

  void getCartData() {
    emit(ShopLoadingGetCartState());
    Dio_Helper.getData(
      url: CARTS,
      token: token,
    ).then((value) {
      getCartModel = GetCartModel.fromJson(value.data);
      print(value.data);
      emit(ShopGetCartSuccessState());
    }).catchError((error) {
      print("errrrror ${error.toString()}");
      emit(ShopGetCartErrorState(error.toString()));
    });
  }

  // Minus quantity for cart
  int quantity = 1;

  void quantityMinus(GetCartModel model, index) {
    emit(ShopMinusQuantityState());

    quantity = model.data.cart_items[index].quantity;
    if (quantity != 0) {
      quantity--;
    } else {
      quantity = 0;
    }
    emit(ShopMinusQuantityState());
  }

  // Plus quantity for cart
  void quantityPlus(GetCartModel model, index) {
    emit(ShopPlusQuantityState());
    quantity = model.data.cart_items[index].quantity;
    quantity++;
    emit(ShopPlusQuantityState());
  }

  void updateCart({
    required int id,
    quantity,
  }) {
    emit(ShopUpdateCartLoadingState());
    Dio_Helper.putData(
      url: UPDATECARTS + '$id',
      token: token,
      data: {
        "quantity": quantity,
      },
    ).then((value) {
      getCartData();
      emit(ShopUpdateCartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateCartErrorState(error.toString()));
    });
  }

  LoginModel? userModel;

  void getProfileData() {
    emit(ShopLoadingProfileState());
    Dio_Helper.getData(url: PROFILE, token: token).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(value.data);
      emit(ShopGetProfileSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetProfileErrorState(error.toString()));
    });
  }

  void updateProfile({
    required String name,
    required String email,
    required String phone,
    required dynamic image,
  }) {
    emit(ShopUpdateProfileLoadingState());
    Dio_Helper.putData(
      url: UPDATEPROFILE,
      data: {
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
      },
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopUpdateProfileSuccessState(userModel!));
    }).catchError((error) {
      print("error update ${error.toString()}");
      emit(ShopUpdateProfileErrorState(error.toString()));
    });
  }

  SettingsModel? settingsModel;

  void getSettingsData() {
    emit(ShopLoadingSettingsState());

    Dio_Helper.getData(url: SETTINGS, lang: 'en').then((value) {
      settingsModel = SettingsModel.fromJson(value.data);
      emit(ShopGetSettingsSuccessState());
    }).catchError((error) {
      emit(ShopGetSettingsErrorState(error.toString()));
    });
  }

  FAQModel? faqModel;

  void getFAQData() {
    emit(ShopLoadingFAQState());
    Dio_Helper.getData(url: FAQ, lang: 'en').then((value) {
      faqModel = FAQModel.fromJson(value.data);
      emit(ShopGetFAQSuccessState());
    }).catchError((error) {
      emit(ShopGetFAQErrorState(error.toString()));
    });
  }

  AddAddressModel? addAddressModel;
  void addAddress({
    required String name,
    required String city,
    required String government,
    dynamic details,
    dynamic notes,
    required dynamic latitude,
    required dynamic longitude,
  }) {
    Dio_Helper.postData(
      url: ADDRESS,
      token: token,
      data: {
        'name': name,
        'city': city,
        'region': government,
        'details': details,
        'notes': notes,
        'latitude': latitude,
        'longitude': longitude,
      },
    ).then((value) {
      addAddressModel = AddAddressModel.fromJson(value.data);
      getAddress();
      emit(ShopAddAddressSuccessState(addAddressModel!));
      print("ID ADD${value.data}");
    }).catchError((error) {
      print(error.toString());
      emit(ShopAddAddressErrorState(error.toString()));
    });
  }

  AddressModel? addressModel;

  void getAddress() {
    emit(ShopGetAddressLoadingState());
    Dio_Helper.getData(
      url: ADDRESS,
      token: token,
    ).then((value) {
      addressModel = AddressModel.fromJson(value.data);
      print(value.data['data']['id']);
      getOrderData();
      print(addressModel!.data!.total);
      emit(ShopGetAddressSuccessState(addressModel!));
    }).catchError((error) {
      emit(ShopGetAddressErrorState(error.toString()));
    });
  }

  DelAddressModel? delAddressModel;
  Future delAddress({required iD}) async {
    emit(ShopDelAddressLoadingState());
    Dio_Helper.deleteData(
      url: "addresses/$iD",
      token: token,
    ).then((value) {
      delAddressModel = DelAddressModel.fromJson(value.data);
      getAddress();
      emit(ShopDelAddressSuccessState(delAddressModel!));
    }).catchError((error) {
      emit(ShopDelAddressErrorState(error.toString()));
    });
  }

  AddOrderModel? addOrderModel;
  void addOrder({
    required addressId,
  }) {
    emit(ShopAddOrderLoadingState());
    Dio_Helper.postData(
      url: ORDERS,
      token: token,
      data: {
        'address_id': addressId,
        "payment_method": 1,
        "use_points": false,
      },
    ).then((value) {
      addOrderModel = AddOrderModel.fromJson(value.data);
      getCartData();
      getOrderData();
      emit(ShopAddOrderSuccessState(addOrderModel!));
    }).catchError((error) {
      emit(
        ShopAddOrderErrorState(error.toString()),
      );
    });
  }

  OrderModel? orderModel;

  void getOrderData() {
    emit(ShopGetOrderLoadingState());
    Dio_Helper.getData(url: ORDERS, token: token, lang: 'en').then((value) {
      orderModel = OrderModel.fromJson(value.data);
      emit(ShopGetOrderSuccessState());
    }).catchError((error) {
      emit(ShopGetOrderErrorState(error.toString()));
    });
  }

  void cancelOrder({
    required int id,
  }) {
    emit(ShopCancelOrderLoadingState());
    Dio_Helper.getData(url: 'orders/$id/cancel', token: token, lang: 'en')
        .then((value) {
      getOrderData();
      emit(ShopCancelOrderSuccessState());
    }).catchError((error) {
      emit(ShopCancelOrderErrorState(error.toString()));
    });
  }

  // uploadCameraImage() async {
  //   emit(ShopGetImageFromCameraLoadingState());
  //   final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
  //   if (pickedImage != null) {
  //     image = File(pickedImage.path);
  //     emit(ShopGetImageFromCameraSuccessState());
  //   } else {
  //     emit(ShopGetImageFromCameraErrorState());
  //   }
  // }
}
