import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/shared/network/shared.styles/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import '../../Layout/shop_app/bloc/cubit.dart';
import '../../models/favorites_model.dart';
import '../../modules/home_products/products_details_screen.dart';

double screenWidth(context) {
  return MediaQuery.of(context).size.width;
}

Future getLatAndLong() async {
  return await Geolocator.getCurrentPosition();
}

double screenHeight(context) {
  return MediaQuery.of(context).size.height;
}

void navigateTo(context, screen) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
      ),
    );

void navigateToFinish(context, screen) =>
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return screen;
    }), (route) => false);

Widget myDivider() => Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey[200],
      ),
    );

defaultTextButton(
        {required Function function,
        required String text,
        Color? color,
        double,
        required context}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: color,
            ),
      ),
    );

void showToast({
  required String msg,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: msg,
        textColor: Colors.white,
        backgroundColor: toastSetColor(state),
        timeInSecForIosWeb: 5,
        fontSize: 14,
        toastLength: Toast.LENGTH_LONG);

enum ToastStates { SUCCESS, ERROR, WARNING }

toastSetColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget buildListItem(model, context, {bool isOldPrice = true}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: InkWell(
      onTap: () {
        ShopCubit.get(context).getProductDetails(model.id).then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductsDetailsScreen(),
              ));
        });
      },
      child: SizedBox(
        height: 120,
        width: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                // Image(
                //   image: NetworkImage(
                //     "${model.product?.image}",
                //   ),
                //   height: 125,
                //   width: 125,
                // ),
                CachedNetworkImage(
                  imageUrl: "${model.image}",
                  height: 125,
                  width: 125,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.red,
                    child: const Text(
                      "DISCOUNT",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model.name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 14),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        "${model.price} EG",
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          "${model.old_price}",
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFav(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey.shade300,
                          child: Icon(
                            ShopCubit.get(context).favorites[model.id]!
                                ? Icons.favorite_outlined
                                : Icons.favorite_outline,
                            color: ShopCubit.get(context).favorites[model.id]!
                                ? Colors.red
                                : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
