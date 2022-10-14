import 'package:flutter/material.dart';
import 'package:flutter_projects/modules/login/login_screen.dart';
import 'package:flutter_projects/shared/network/local/cache_helper.dart';
import 'package:flutter_projects/shared/shared_components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/network/shared.styles/colors.dart';
import '../sign_up/signup_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class OnBoardingItem {
  final String image;
  final String title;
  final String body;

  OnBoardingItem({
    required this.image,
    required this.title,
    required this.body,
  });
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();
  bool isLast = false;
  List<OnBoardingItem> board = [
    OnBoardingItem(
      image: 'assets/Images/Onboarding1.png',
      title: 'Explore',
      body:
          'Choose what ever the product you wish for with the easiest way possible using MATJAR',
    ),
    OnBoardingItem(
      image: 'assets/Images/delivery_truck.png',
      title: 'Shopping',
      body: 'Your order will be delivered very quickly and carefully',
    ),
    OnBoardingItem(
      image: 'assets/Images/payments.png',
      title: 'Make the payment',
      body: 'Fast and secure payment process, you can pay cash or credit',
    ),
  ];

  void SKIP() {
    Cache_Helper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateToFinish(context, const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "MATJAR",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        actions: [
          defaultTextButton(
              function: SKIP,
              text: "SKIP",
              color: Colors.white,
              double: 15.0,
              context: context)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int value) {
                  if (value == board.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildOnBoardingItem(board[index]),
                itemCount: board.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    expansionFactor: 3,
                    dotWidth: 10,
                    dotHeight: 10,
                    activeDotColor: defaultColor,
                  ),
                  controller: pageController,
                  count: 3,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      Cache_Helper.saveData(
                        key: 'onBoarding',
                        value: true,
                      ).then((value) {
                        if (value) {
                          navigateToFinish(context, LoginScreen());
                        }
                      });
                    } else {
                      pageController.nextPage(
                          duration: Duration(seconds: 2),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  backgroundColor: defaultColor,
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItem(OnBoardingItem model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(model.image),
                ),
              ),
            ),
          ),
          Text(
            model.title,
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            model.body,
            style:
                Theme.of(context).textTheme.headline4!.copyWith(fontSize: 18),
          ),
        ],
      );
}
