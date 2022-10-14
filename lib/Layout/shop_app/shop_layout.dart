import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/cubit.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/states.dart';
import 'package:flutter_projects/models/HomeModel.dart';
import 'package:flutter_projects/modules/search/search_screen.dart';
import 'package:flutter_projects/shared/network/shared.styles/colors.dart';
import 'package:flutter_projects/shared/shared_components/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            height: 60,
            color: Colors.grey.shade200,
            backgroundColor: defaultColor,
            animationDuration: const Duration(
              milliseconds: 350,
            ),
            index: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: cubit.iconData,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
