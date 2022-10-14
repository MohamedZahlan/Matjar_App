import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/cubit.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/states.dart';
import 'package:flutter_projects/models/orders_model.dart';
import 'package:flutter_projects/shared/network/shared.styles/colors.dart';
import 'package:flutter_projects/shared/shared_components/components.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              centerTitle: true,
              title: const Text("My orders"),
            ),
            body: ConditionalBuilder(
              condition: cubit.orderModel != null,
              builder: (context) => state is ShopGetOrderLoadingState
                  ? const LinearProgressIndicator()
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildOrdersItem(
                          cubit.orderModel!.data!.data[index], context),
                      separatorBuilder: (context, index) => myDivider(),
                      itemCount: cubit.orderModel!.data!.data.length,
                    ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ));
      },
    );
  }

  Widget buildOrdersItem(Data data, context) => Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                const Text("Date :"),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${data.date}",
                  style: TextStyle(color: defaultColor),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text("Order id :"),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${data.id}",
                  style: TextStyle(color: defaultColor),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text("Total :"),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${data.total}",
                  style: TextStyle(color: defaultColor),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "${data.status}",
                  style: TextStyle(
                      color: data.status == 'New' ? defaultColor : Colors.red,
                      fontSize: 15),
                ),
                const Spacer(),
                if (data.status == "New")
                  ElevatedButton(
                    onPressed: () {
                      ShopCubit.get(context).cancelOrder(id: data.id);
                      ShopCubit.get(context).getOrderData();
                    },
                    child: const Text(
                      'Cancel',
                    ),
                  )
              ],
            ),
          ],
        ),
      );
}
