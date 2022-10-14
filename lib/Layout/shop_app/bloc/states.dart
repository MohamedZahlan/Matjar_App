import 'package:flutter_projects/models/cart_model.dart';
import 'package:flutter_projects/models/changefav.dart';
import 'package:flutter_projects/models/login_model.dart';

import '../../../models/add_address.dart';
import '../../../models/add_order.dart';
import '../../../models/address_model.dart';
import '../../../models/del_address.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopGetHomeDataSuccessState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopGetHomeDataErrorState extends ShopStates {
  final error;

  ShopGetHomeDataErrorState(this.error);
}

class ShopGetCategoriesDataSuccessState extends ShopStates {}

class ShopLoadingCategoriesDataState extends ShopStates {}

class ShopGetCategoriesDataErrorState extends ShopStates {
  final error;

  ShopGetCategoriesDataErrorState(this.error);
}

class ShopGetCategoriesDetailsSuccessState extends ShopStates {}

class ShopLoadingCategoriesDetailsState extends ShopStates {}

class ShopGetCategoriesDetailsErrorState extends ShopStates {
  final error;

  ShopGetCategoriesDetailsErrorState(this.error);
}

class ShopChangFavState extends ShopStates {}

class ShopChangFavSuccessState extends ShopStates {
  final ChangeFavModel changeFavModel;

  ShopChangFavSuccessState(this.changeFavModel);
}

class ShopChangeFavErrorState extends ShopStates {
  final error;

  ShopChangeFavErrorState(this.error);
}

class ShopLoadingFavSuccessState extends ShopStates {}

class ShopGetFavSuccessState extends ShopStates {}

class ShopGetFavErrorState extends ShopStates {
  final error;

  ShopGetFavErrorState(this.error);
}

class ShopGetProductDetailsSuccessState extends ShopStates {}

class ShopGetProductDetailsErrorState extends ShopStates {
  final error;

  ShopGetProductDetailsErrorState(this.error);
}

class ShopLoadingProductDetailsState extends ShopStates {}

class ShopChangeIndicatorState extends ShopStates {}

class ShopChangeCartState extends ShopStates {}

class ShopChangeCartSuccessState extends ShopStates {
  final CartModel cartModel;

  ShopChangeCartSuccessState(this.cartModel);
}

class ShopChangeCartErrorState extends ShopStates {
  final error;

  ShopChangeCartErrorState(this.error);
}

class ShopLoadingGetCartState extends ShopStates {}

class ShopGetCartSuccessState extends ShopStates {}

class ShopGetCartErrorState extends ShopStates {
  final error;

  ShopGetCartErrorState(this.error);
}

class ShopPlusQuantityState extends ShopStates {}

class ShopMinusQuantityState extends ShopStates {}

class ShopUpdateCartLoadingState extends ShopStates {}

class ShopUpdateCartSuccessState extends ShopStates {}

class ShopUpdateCartErrorState extends ShopStates {
  final error;

  ShopUpdateCartErrorState(this.error);
}

class ShopLoadingProfileState extends ShopStates {}

class ShopGetProfileSuccessState extends ShopStates {}

class ShopGetProfileErrorState extends ShopStates {
  final error;

  ShopGetProfileErrorState(this.error);
}

class ShopUpdateProfileLoadingState extends ShopStates {}

class ShopUpdateProfileSuccessState extends ShopStates {
  final LoginModel updateModel;

  ShopUpdateProfileSuccessState(this.updateModel);
}

class ShopUpdateProfileErrorState extends ShopStates {
  final error;

  ShopUpdateProfileErrorState(this.error);
}

class ShopLoadingSettingsState extends ShopStates {}

class ShopGetSettingsSuccessState extends ShopStates {}

class ShopGetSettingsErrorState extends ShopStates {
  final error;

  ShopGetSettingsErrorState(this.error);
}

class ShopLoadingFAQState extends ShopStates {}

class ShopGetFAQSuccessState extends ShopStates {}

class ShopGetFAQErrorState extends ShopStates {
  final error;

  ShopGetFAQErrorState(this.error);
}

class ShopAddAddressLoadingState extends ShopStates {}

class ShopAddAddressSuccessState extends ShopStates {
  final AddAddressModel addAddressModel;

  ShopAddAddressSuccessState(this.addAddressModel);
}

class ShopAddAddressErrorState extends ShopStates {
  final error;

  ShopAddAddressErrorState(this.error);
}

class ShopGetAddressLoadingState extends ShopStates {}

class ShopGetAddressSuccessState extends ShopStates {
  final AddressModel addressModel;

  ShopGetAddressSuccessState(this.addressModel);
}

class ShopGetAddressErrorState extends ShopStates {
  final error;

  ShopGetAddressErrorState(this.error);
}

class ShopAddOrderLoadingState extends ShopStates {}

class ShopAddOrderSuccessState extends ShopStates {
  final AddOrderModel addOrderModel;

  ShopAddOrderSuccessState(this.addOrderModel);
}

class ShopAddOrderErrorState extends ShopStates {
  final error;

  ShopAddOrderErrorState(this.error);
}

class ShopGetOrderLoadingState extends ShopStates {}

class ShopGetOrderSuccessState extends ShopStates {}

class ShopGetOrderErrorState extends ShopStates {
  final error;

  ShopGetOrderErrorState(this.error);
}

class ShopCancelOrderLoadingState extends ShopStates {}

class ShopCancelOrderSuccessState extends ShopStates {}

class ShopCancelOrderErrorState extends ShopStates {
  final error;

  ShopCancelOrderErrorState(this.error);
}

class ShopDelAddressLoadingState extends ShopStates {}

class ShopDelAddressSuccessState extends ShopStates {
  final DelAddressModel delAddressModel;

  ShopDelAddressSuccessState(this.delAddressModel);
}

class ShopDelAddressErrorState extends ShopStates {
  final error;

  ShopDelAddressErrorState(this.error);
}

class ShopGetImageFromGalleryLoadingState extends ShopStates {}

class ShopGetImageFromGallerySuccessState extends ShopStates {}

class ShopGetImageFromGalleryErrorState extends ShopStates {}

class ShopGetImageFromCameraLoadingState extends ShopStates {}

class ShopGetImageFromCameraSuccessState extends ShopStates {}

class ShopGetImageFromCameraErrorState extends ShopStates {}
