import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_projects/Layout/shop_app/shop_layout.dart';
import 'package:flutter_projects/modules/home_products/products_screen.dart';
import 'package:flutter_projects/modules/login/bloc/cubit.dart';
import 'package:flutter_projects/shared/network/local/cache_helper.dart';
import 'package:flutter_projects/shared/shared_components/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Layout/shop_app/bloc/cubit.dart';
import '../../shared/network/shared.styles/colors.dart';
import '../../shared/shared_components/components.dart';
import '../sign_up/signup_screen.dart';
import 'bloc/states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginGetDataSuccessState) {
            if (state.loginModel.status == true) {
              showToast(
                  msg: state.loginModel.message.toString(),
                  state: ToastStates.SUCCESS);
              print(state.loginModel.data.token);
              Cache_Helper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value) {
                token = state.loginModel.data.token;
                navigateToFinish(context, const ShopLayout());
                ShopCubit.get(context).currentIndex = 0;
                ShopCubit.get(context).getHomeData();
                ShopCubit.get(context).getSettingsData();
                ShopCubit.get(context).getFavData();
                ShopCubit.get(context).getCategoriesData();
                ShopCubit.get(context).getCartData();
                if (value) {
                  navigateToFinish(context, const ShopLayout());
                }
              });
            } else {
              showToast(
                  msg: state.loginModel.message.toString(),
                  state: ToastStates.ERROR);
            }
          }
          if (state is LoginGetDataErrorState) {
            showToast(
                msg: "Make sure the data entered is correct",
                state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            //appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 170,
                          width: 170,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/Images/Mobile_login.png'))),
                        ),
                        Text(
                          "Sign in now to browse our hot offers",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.email_outlined),
                            labelText: "Enter your e-mail",
                          ),
                          maxLines: 1,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'E-mail must not be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.lock_outline),
                            labelText: "Enter your password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.changePasswordMode();
                              },
                              icon: cubit.isPasswordShow
                                  ? const Icon(Icons.visibility_off_outlined)
                                  : const Icon(Icons.visibility_outlined),
                            ),
                          ),
                          maxLines: 1,
                          obscureText: cubit.isPasswordShow,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password must not be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingDataState,
                          builder: (context) => Container(
                            width: double.infinity,
                            color: defaultColor,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate() == true) {
                                  cubit.getUserData(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                                // navigateToFinish(context, ShopLayout());
                                // print(token);
                              },
                              child: Text(
                                'Sign In',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            defaultTextButton(
                                function: () {
                                  navigateToFinish(
                                      context, const SignUpScreen());
                                },
                                text: "Sign Up",
                                context: context,
                                color: defaultColor),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
