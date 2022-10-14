import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/cubit.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/states.dart';
import 'package:flutter_projects/modules/order/my_order.dart';
import 'package:flutter_projects/modules/order/order_screen.dart';
import 'package:flutter_projects/shared/network/shared.styles/colors.dart';
import 'package:flutter_projects/shared/shared_components/components.dart';
import 'package:geolocator/geolocator.dart';

import '../../models/address_model.dart';

class MyLocationScreen extends StatelessWidget {
  const MyLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopDelAddressSuccessState) {
          showToast(
              msg: state.delAddressModel.message.toString(),
              state: state.delAddressModel.status!
                  ? ToastStates.SUCCESS
                  : ToastStates.ERROR);
        }
        if (state is ShopAddOrderSuccessState) {
          showToast(
              msg: state.addOrderModel.message.toString(),
              state: state.addOrderModel.status!
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
                icon: const Icon(Icons.arrow_back_ios)),
            title: const Text("Location", style: TextStyle(fontSize: 25)),
            actions: [
              IconButton(
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
                    }
                    navigateTo(context, OrderScreen());
                  },
                  icon: const Icon(Icons.add_location_alt))
            ],
          ),
          body: cubit.addressModel!.data!.data.isEmpty
              ? const Center(
                  child: Text("Add your address now to confirm your order"))
              : state is ShopGetAddressSuccessState
                  ? const Center(child: CircularProgressIndicator())
                  : ConditionalBuilder(
                      condition: state is! ShopGetAddressLoadingState,
                      builder: (context) => ListView.separated(
                        itemBuilder: (context, index) => buildLocationItem(
                            cubit.addressModel!.data!.data[index], context),
                        separatorBuilder: (context, index) => SizedBox(),
                        itemCount: cubit.addressModel!.data!.data.length,
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
          bottomNavigationBar:
              buildBottomNav(cubit.addressModel!.data!.data.first, context),
        );
      },
    );
  }

  Widget buildLocationItem(Data data, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  border: Border.all(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Name    : ",
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${data.name} ",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text(
                          "City        : ",
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${data.city} ",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Region   : ",
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${data.government} ",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Details   : ",
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${data.details} ",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Notes     : ",
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${data.notes} ",
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .delAddress(iD: data.id)
                                  .then((value) {
                                navigateTo(context, const MyLocationScreen());
                              });
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildBottomNav(Data data, context) => Container(
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: defaultColor, borderRadius: BorderRadius.circular(20)),
        child: MaterialButton(
          onPressed: () {
            ShopCubit.get(context).addOrder(addressId: data.id);
            navigateTo(context, const MyOrdersScreen());
            ShopCubit.get(context).getProductDetails(data.id);
          },
          child: Text(
            ShopCubit.get(context).addressModel!.data!.data.isEmpty
                ? "Add your address"
                : "Order Now",
            style: const TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
      );
}
