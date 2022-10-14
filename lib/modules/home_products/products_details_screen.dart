import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/cubit.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/states.dart';
import 'package:flutter_projects/models/product_details_model.dart';
import 'package:flutter_projects/modules/cart/cart_screen.dart';
import 'package:flutter_projects/modules/search/search_screen.dart';
import 'package:flutter_projects/shared/network/shared.styles/colors.dart';
import 'package:flutter_projects/shared/shared_components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductsDetailsScreen extends StatelessWidget {
  const ProductsDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopChangeCartSuccessState) {
          showToast(
            msg: state.cartModel.message.toString(),
            state: state.cartModel.status!
                ? ToastStates.SUCCESS
                : ToastStates.ERROR,
          );
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Product Details",
            ),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
              ),
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
                        ));
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                  )),
            ],
          ),
          body: state is ShopLoadingProductDetailsState &&
                  cubit.productDetailsModel == null
              ? const Center(child: CircularProgressIndicator())
              : buildProductDetails(cubit.productDetailsModel!, context),
        );
      },
    );
  }

  Widget buildProductDetails(ProductDetailsModel model, context) {
    var pageController = PageController();
    // for carouserSlider
    List<Widget> images = [];
    model.data.images.forEach((element) {
      images.add(Image.network(
        element,
        //fit: BoxFit.cover,
      ));
    });
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.5),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  CarouselSlider(
                    items: images,
                    options: CarouselOptions(
                        //height: 190,
                        scrollDirection: Axis.horizontal,
                        initialPage: 0,
                        onPageChanged: (int x, reason) {
                          ShopCubit.get(context).changeProductImage(x);
                        },
                        reverse: false,
                        autoPlay: false,
                        viewportFraction: 1.0),
                  ),
                  AnimatedSmoothIndicator(
                    activeIndex: ShopCubit.get(context).activeIndex,
                    count: images.length,
                    effect: ExpandingDotsEffect(
                        activeDotColor: defaultColor,
                        dotWidth: 15,
                        dotHeight: 15),
                  ),
                ],
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeFav(model.data.id!);
                    },
                    icon: ShopCubit.get(context).favorites[model.data.id]!
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
              const SizedBox(
                height: 12,
              ),
              Text(
                model.data.name,
                maxLines: 2,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 18,
                ),
              ),
              Text(
                "Description :",
                style: TextStyle(color: defaultColor, fontSize: 16),
              ),
              Text(
                model.data.description,
                //maxLines: 15,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          margin: const EdgeInsets.only(
            bottom: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${model.data.price} EGP",
                    style: TextStyle(color: defaultColor, fontSize: 15),
                  ),
                  Text(
                    "Price",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 225,
                decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton.icon(
                  onPressed: () {
                    ShopCubit.get(context).changeCartsItem(model.data.id!);
                  },
                  icon: Icon(
                    ShopCubit.get(context).inCart[ShopCubit.get(context)
                            .productDetailsModel!
                            .data
                            .id]!
                        ? Icons.shopping_cart
                        : Icons.add_shopping_cart,
                    color: Colors.white,
                  ),
                  label: ShopCubit.get(context).inCart[
                          ShopCubit.get(context).productDetailsModel!.data.id]!
                      ? const Text(
                          "Added",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      : const Text(
                          "Add to cart",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
