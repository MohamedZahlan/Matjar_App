import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/cubit.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/states.dart';
import 'package:flutter_projects/models/favorites_model.dart';
import 'package:flutter_projects/modules/cart/cart_screen.dart';
import 'package:flutter_projects/modules/home_products/products_details_screen.dart';
import 'package:flutter_projects/shared/shared_components/components.dart';

import '../../shared/network/shared.styles/colors.dart';
import '../../shared/shared_components/constants.dart';
import '../search/search_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopLoadingFavSuccessState) {
          LinearProgressIndicator();
        }
        // Phoenix.rebirth(context);
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.favModel != null,
          builder: (context) => Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Favorites",
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchScreen(),
                          ));
                    },
                    icon: const Icon(
                      Icons.search,
                    )),
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
                    )),
              ],
            ),
            body: cubit.favModel!.data!.data.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/Images/Wishlist.png'),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Your wishlist is Empty!',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  )
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildListItem(
                        cubit.favModel!.data!.data[index].product!, context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: cubit.favModel!.data!.data.length,
                  ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
//cubit.favModel != null
