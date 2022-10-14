import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/cubit.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/states.dart';
import 'package:flutter_projects/modules/order/my_order.dart';
import 'package:flutter_projects/modules/settings/privacy_policy_screen.dart';
import 'package:flutter_projects/modules/settings/profile_screen.dart';
import 'package:flutter_projects/modules/settings/web_view.dart';
import 'package:flutter_projects/shared/shared_components/components.dart';
import 'package:flutter_projects/shared/shared_components/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../shared/network/shared.styles/colors.dart';
import '../cart/cart_screen.dart';
import '../search/search_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var user = ShopCubit.get(context).userModel;
        // nameController.text = user!.data!.name!;
        // emailController.text = user.data!.email!;
        // phoneController.text = user.data!.phone!;
        return cubit.userModel == null
            ? const LinearProgressIndicator()
            : ConditionalBuilder(
                condition: user != null && state is! ShopLoadingProfileState,
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: const Text(
                      "Settings",
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.search),
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  body: cubit.userModel == null
                      ? const Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: const EdgeInsets.all(20),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Form(
                              key: formKey,
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    radius: 60,
                                    child: Image(
                                      width: 200,
                                      height: 150,
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        'https://cdn.icon-icons.com/icons2/2643/PNG/512/male_man_people_person_avatar_white_tone_icon_159363.png',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${user!.data.name}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "${user.data.email}",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // account settings
                                  Text(
                                    "Account",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 18, color: defaultColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProfileScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 55,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.account_circle,
                                            color: defaultColor,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            "Profile",
                                          ),
                                          const Spacer(),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: defaultColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MyOrdersScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 55,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.shopping_basket_outlined,
                                            color: defaultColor,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            "My orders",
                                          ),
                                          const Spacer(),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: defaultColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //settings
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Settings",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 18, color: defaultColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 55,
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.dark_mode_outlined,
                                          color: defaultColor,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          "Dark mode",
                                        ),
                                        const Spacer(),
                                        Switch(
                                          value: false,
                                          onChanged: (value) {
                                            value = false;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  //Legal for app
                                  Text(
                                    "Legal",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 18, color: defaultColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PrivacyPolicyScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 55,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.privacy_tip,
                                            color: defaultColor,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            "Privacy Policy",
                                          ),
                                          const Spacer(),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: defaultColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        backgroundColor: Colors.grey.shade200,
                                        context: context,
                                        builder: (context) => Container(
                                          height: 150,
                                          margin: EdgeInsets.all(20),
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                topLeft: Radius.circular(20),
                                              )),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        facebook();
                                                      },
                                                      icon: const Icon(
                                                        Icons.facebook,
                                                        color: Colors.blue,
                                                        size: 60,
                                                      )),
                                                  const SizedBox(
                                                    height: 18,
                                                  ),
                                                  const Text("Facebook")
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        whatsapp();
                                                      },
                                                      icon: const Icon(
                                                        Icons.whatsapp,
                                                        color: Colors.green,
                                                        size: 60,
                                                      )),
                                                  const SizedBox(
                                                    height: 18,
                                                  ),
                                                  const Text(
                                                    "WhatsApp",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      linkedin();
                                                    },
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                        top: 5,
                                                      ),
                                                      height: 55,
                                                      width: 55,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        image:
                                                            const DecorationImage(
                                                          image: AssetImage(
                                                              "assets/Images/linkedin-logo.png"),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  const Text(
                                                    "LinkedIn",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 55,
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.contact_support,
                                            color: defaultColor,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            "Contact me",
                                          ),
                                          const Spacer(),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: defaultColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  //FAQ for app
                                  Text(
                                    "FAQ",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 18, color: defaultColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) => Container(
                                            color: Colors.grey.shade200,
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Answer :   ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${cubit.faqModel!.data!.data[index].answer}",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 55,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.question_mark,
                                              color: defaultColor,
                                              size: 30,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "${cubit.faqModel!.data!.data[index].question}",
                                            ),
                                            const Spacer(),
                                            Icon(
                                              Icons.keyboard_arrow_down,
                                              color: defaultColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      height: 10,
                                    ),
                                    itemCount:
                                        cubit.faqModel!.data!.data.length,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      signOut(context);
                                    },
                                    child: Container(
                                      height: 55,
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.logout,
                                            color: defaultColor,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            "Logout",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              );
      },
    );
  }

  void whatsapp() async {
    const url = "https://wa.me/qr/HZBBFPOVS6R5P1";
    if (!await launch(url)) throw 'Could not launch $url';
  }

  void linkedin() async {
    const url =
        'https://www.linkedin.com/in/mohamed-zahlan-6027b4215?fbclid=IwAR1Wyyey0NFlJs2PVA-ecJgjpWwvwFWP8zpajH-DDz7J9dPZG-6Xx-DF-1U';
    if (await launch(url)) throw 'could not launch $url ';
  }

  void facebook() async {
    const url = "https://www.facebook.com/mohamed.zahlan2";

    if (!await launch(url)) throw "couldn't launch $url ";
  }
}
