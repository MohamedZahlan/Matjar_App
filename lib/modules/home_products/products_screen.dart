import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/models/categories_model.dart';
import 'package:flutter_projects/modules/categories/categories_screen.dart';
import 'package:flutter_projects/modules/home_products/products_details_screen.dart';
import 'package:flutter_projects/shared/shared_components/components.dart';
import '../../Layout/shop_app/bloc/cubit.dart';
import '../../Layout/shop_app/bloc/states.dart';
import '../../models/HomeModel.dart';
import '../../shared/network/shared.styles/colors.dart';
import '../cart/cart_screen.dart';
import '../search/search_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopChangFavSuccessState) {
          showToast(
            msg: state.changeFavModel.message.toString(),
            state: state.changeFavModel.status!
                ? ToastStates.SUCCESS
                : ToastStates.ERROR,
          );
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "MATJAR",
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
          body: ConditionalBuilder(
            condition: cubit.homeModel != null &&
                cubit.categoriesModel != null &&
                cubit.getCartModel != null,
            builder: (context) => buildProductItem(
                cubit.homeModel!, cubit.categoriesModel!, context),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildProductItem(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: screenHeight(context) / 3,
              decoration: BoxDecoration(
                color: defaultColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  CarouselSlider(
                    items: model.data?.banners
                        .map(
                          (e) => CachedNetworkImage(
                            imageUrl: '${e.image}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      initialPage: 0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 1),
                      autoPlayAnimationDuration: const Duration(seconds: 3),
                      enableInfiniteScroll: true,
                      reverse: false,
                      //aspectRatio: 1.0,
                      viewportFraction: 1.0,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                      pauseAutoPlayOnTouch: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  "Categories",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const Spacer(),
                defaultTextButton(
                  context: context,
                  function: () {
                    navigateTo(context, const CategoriesScreen());
                  },
                  text: 'View all',
                  double: 15.0,
                  color: defaultColor,
                )
              ],
            ),
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildCategoriesItem(
                    categoriesModel.data!.data[index], context),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 5,
                ),
                itemCount: categoriesModel.data!.data.length,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Products",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.75,
              children: List.generate(
                model.data!.products.length,
                (index) => InkWell(
                    onTap: () {
                      ShopCubit.get(context)
                          .getProductDetails(model.data!.products[index].id)
                          .then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductsDetailsScreen(),
                          ),
                        );
                      });
                    },
                    child: buildGridItem(model.data!.products[index], context)),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoriesItem(CategoriesDataModel model, context) => InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => CategoriesDetails(),
          //   ),
          // );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              // Image(
              //   image: NetworkImage('${model.image}'),
              //   height: 120,
              //   width: 120,
              //   fit: BoxFit.cover,
              // ),
              CachedNetworkImage(
                imageUrl: '${model.image}',
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
              Container(
                width: 120,
                color: Colors.black.withOpacity(0.5),
                child: Text(
                  "${model.name}",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 15, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildGridItem(ProductsData model, context) => Padding(
        padding: const EdgeInsets.all(5.5),
        child: Container(
          //color: ThemeMode.dark? Colors.black : Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  // Image(
                  //   image:,
                  //   height: 200,
                  // ),
                  CachedNetworkImage(
                    imageUrl: "${model.image}",
                    //placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    height: 200,
                  ),
                  if (model.discount != 0)
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
              Text(
                "${model.name}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
              Row(
                children: [
                  Text(
                    "${model.price} EPG",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 12.6, color: defaultColor),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  if (model.discount != 0)
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
                    icon: ShopCubit.get(context).favorites[model.id]!
                        ? CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey.shade300,
                            child: const Icon(
                              Icons.favorite_outlined,
                              color: Colors.red,
                            ),
                          )
                        : CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey.shade300,
                            child: const Icon(
                              Icons.favorite_outline,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
