import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/cubit.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/states.dart';
import 'package:flutter_projects/modules/order/my_locations.dart';
import 'package:flutter_projects/modules/order/my_order.dart';
import 'package:flutter_projects/shared/network/shared.styles/colors.dart';
import 'package:flutter_projects/shared/shared_components/components.dart';
import 'package:geolocator/geolocator.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);

  static final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final governmentController = TextEditingController();
  final detailsController = TextEditingController();
  final notesController = TextEditingController();

  dynamic latitude;
  dynamic longitude;

  Future getlatitude_longitude() async {
    bool service;
    service = await Geolocator.isLocationServiceEnabled();
    print(service);
    if (service == false) {
      showToast(
          msg: "Please enable location services", state: ToastStates.ERROR);
    }
    // var per = await Geolocator.checkPermission();
    // // if (per == LocationPermission.denied) {
    // //   per = await Geolocator.requestPermission();
    // if (per == LocationPermission.always) {
    //   getLatAndLong();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopAddAddressSuccessState) {
          //ShopAddAddressSuccessState
          showToast(
            msg: state.addAddressModel.message.toString(),
            state: state.addAddressModel.status!
                ? ToastStates.SUCCESS
                : ToastStates.ERROR,
          );
          if (state.addAddressModel.status == true) {
            navigateTo(context, const MyLocationScreen());
          }
          getLatAndLong();
        }
        getlatitude_longitude();
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        dynamic index;
        return state is ShopAddAddressSuccessState
            ? const LinearProgressIndicator()
            : Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    "Location",
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          if (state is ShopAddAddressSuccessState)
                            const LinearProgressIndicator(),
                          Center(
                            child: Text(
                              "LOCATION INFORMATION",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            onTap: () {},
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              prefixIcon: const Icon(
                                Icons.person_outline_outlined,
                                size: 30,
                              ),
                              label: Text(
                                "Name",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 15),
                              ),
                            ),
                            maxLines: 1,
                            keyboardType: TextInputType.name,
                            controller: nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            onTap: () {
                              getLatAndLong().then((value) async {
                                await Geolocator.requestPermission();
                                Position c = value;
                                latitude = c.latitude;
                                longitude = c.longitude;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              prefixIcon: const Icon(
                                Icons.add_location_alt_outlined,
                                size: 30,
                              ),
                              label: Text(
                                "City",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 15),
                              ),
                            ),
                            keyboardType: TextInputType.streetAddress,
                            controller: cityController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "city must not be empty";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              prefixIcon: const Icon(
                                Icons.add_location_alt_outlined,
                                size: 30,
                              ),
                              label: Text(
                                "Government",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 15),
                              ),
                            ),
                            maxLines: 1,
                            keyboardType: TextInputType.streetAddress,
                            controller: governmentController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "must not be empty";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                prefixIcon: const Icon(
                                  Icons.notes,
                                  size: 30,
                                ),
                                label: Text(
                                  "Details",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              controller: detailsController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your address details";
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              prefixIcon: const Icon(
                                Icons.note_alt_sharp,
                                size: 30,
                              ),
                              label: Text(
                                "Notes",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 15),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            controller: notesController,
                          ),
                        ],
                      ),
                    ),
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
                          onPressed: () {
                            getlatitude_longitude();
                            if (formkey.currentState!.validate()) {
                              cubit.addAddress(
                                name: nameController.text,
                                city: cityController.text,
                                government: governmentController.text,
                                details: detailsController.text,
                                notes: notesController.text,
                                latitude: latitude,
                                longitude: longitude,
                              );
                              ShopCubit.get(context).getCartData();
                            }
                          },
                          icon: const Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Confirm",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
