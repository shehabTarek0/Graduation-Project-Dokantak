import 'package:flutter/material.dart';
import 'package:g_project/modules/start/start.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String body;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;
  List<OnBoardingModel> boarding = [
    OnBoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'Client',
        body:
            'In the application, the Client can see a large number of handmade products and buy them in the easiest way'),
    OnBoardingModel(
        image: 'assets/images/121.webp',
        title: 'Merchant',
        body:
            "The Merchant can upload his product, modify it, delete it, and sell it from home, free of charge, and looks at clients' requests"),
    OnBoardingModel(
        image: 'assets/images/122.webp',
        title: 'Admins',
        body:
            'We simplify the way of delivery between the merchant and the client and look at the requests of clients and the products of merchants and examine them well')
  ];
  void submit() {
    CacheHelper.saveData(key: 'onBoard', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, const StartScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: defaultTextButton(
                  onPress: submit,
                  text: 'Skip',
                  style: const TextStyle(color: Colors.black, fontSize: 18)),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                  child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardController,
                itemBuilder: (context, index) =>
                    onBoardingItem(boarding[index]),
                itemCount: 3,
              )),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                        activeDotColor: Colors.redAccent,
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget onBoardingItem(OnBoardingModel model) => Column(
        children: [
          Expanded(child: Image(image: AssetImage(model.image))),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            model.body,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                height: 1.3),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      );
}
