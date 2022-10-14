import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/cubit.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/states.dart';
import 'package:flutter_projects/models/get_cart_model.dart';
import 'package:flutter_projects/modules/home_products/products_details_screen.dart';
import 'package:flutter_projects/modules/order/order_screen.dart';
import 'package:flutter_projects/shared/shared_components/components.dart';
import 'package:geolocator/geolocator.dart';
import '../../shared/network/shared.styles/colors.dart';
import '../order/my_locations.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopChangeCartSuccessState) {
          showToast(
              msg: state.cartModel.message.toString(),
              state: state.cartModel.status!
                  ? ToastStates.SUCCESS
                  : ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
            title: const Text(
              "My Cart",
              style: TextStyle(color: Colors.white),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text(
                      "Total Price:",
                      style: TextStyle(fontSize: 15),
                    ),
                    const Spacer(),
                    Text(
                      "${cubit.getCartModel!.data.total} EGP",
                      style: TextStyle(fontSize: 16, color: defaultColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  //margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.circular(0)),
                  child: TextButton.icon(
                    onPressed: () async {
                      dynamic service;
                      if (cubit.getCartModel!.data.total != 0) {
                        service = await Geolocator.isLocationServiceEnabled();
                        print(service);
                        if (service == false) {
                          showToast(
                              msg: "Please enable location services",
                              state: ToastStates.ERROR);
                        }
                        if (cubit.addressModel!.data!.data.isNotEmpty) {
                          navigateTo(context, MyLocationScreen());
                        } else {
                          navigateTo(context, OrderScreen());
                        }
                      } else {
                        showToast(
                          msg: "Cart is empty ,please select any product",
                          state: ToastStates.ERROR,
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.shopping_cart_checkout,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "CheckOut",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: cubit.getCartModel!.data.cart_items.length != 0
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildCardItem(
                      cubit.getCartModel!.data.cart_items[index],
                      context,
                      index,
                      ShopCubit.get(context).getCartModel!),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: cubit.getCartModel!.data.cart_items.length,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/Images/Onboarding1.png'),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Cart is Empty!',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget buildCardItem(
      CartItems model, context, index, GetCartModel getCartModel) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context)
            .getProductDetails(model.product!.id!)
            .then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductsDetailsScreen(),
            ),
          );
        });
      },
      child: Container(
        height: 170,
        width: double.infinity,
        color: Colors.grey.shade100,
        margin: const EdgeInsets.all(20),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: '${model.product?.image}',
              height: 120,
              width: 120,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "'${model.product?.name}'",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.product?.price} EPG',
                        style: TextStyle(color: defaultColor, fontSize: 12.5),
                      ),
                      const SizedBox(width: 6.0),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context)
                              .quantityMinus(getCartModel, index);
                          ShopCubit.get(context).updateCart(
                              id: getCartModel.data.cart_items[index].id!,
                              quantity: ShopCubit.get(context).quantity);
                        },
                        padding: const EdgeInsets.only(bottom: 15),
                        icon: const Icon(
                          Icons.minimize_sharp,
                          size: 25,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        '${model.quantity}',
                        // style: TextStyle(color: defaultColor, fontSize: 14),
                      ),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context)
                              .quantityPlus(getCartModel, index);
                          ShopCubit.get(context).updateCart(
                              id: getCartModel.data.cart_items[index].id!,
                              quantity: ShopCubit.get(context).quantity);
                        },
                        icon: Icon(
                          Icons.add,
                          size: 20,
                          color: defaultColor,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    padding: const EdgeInsets.symmetric(horizontal: 150),
                    onPressed: () {
                      ShopCubit.get(context)
                          .changeCartsItem(model.product!.id!);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
