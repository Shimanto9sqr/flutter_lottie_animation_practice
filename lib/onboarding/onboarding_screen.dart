import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:lottie_animation/onboarding/custom_painter.dart';
import 'package:lottie_animation/onboarding/dotindicator.dart';
import 'package:lottie_animation/onboarding/onboarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentIndex = 0;
  final PageController _pagecontroller = PageController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomPaint(
            painter: ArcPainter(),
            child: SizedBox(
              height: screenSize.height/1.4,
              width: screenSize.width,
            ),

          ),
          Positioned(
            top: 130,
            right: 5,
            left: 5,
            child: Lottie.asset(
              splashes[_currentIndex].lottieFile,
              key: Key('${Random().nextInt(999999999)}'),
              width: 600,
              alignment: Alignment.topCenter,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 270,
              child: Column(
                children: [
                  Flexible(
                      child: PageView.builder(
                          controller: _pagecontroller,
                          itemCount: splashes.length,
                          itemBuilder: (BuildContext context, int index){
                            OnBoardingModel splash = splashes[index];
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  splash.title,
                                  style: const TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 50,),
                                Text(
                                  splash.subtitle,
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white70,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          },
                        onPageChanged: (value){
                            _currentIndex = value;
                            setState(() {});
                        },
                      ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for(int index =0; index<splashes.length;index++)
                        DotIndicator(isSelected: index==_currentIndex,)
                    ],
                  ),
                  const SizedBox(height: 75,),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(_currentIndex==2){
              _pagecontroller.animateToPage(
              0,
              duration: const Duration(microseconds: 300),
              curve: Curves.linear,
              );
            } else {
              _pagecontroller.nextPage(
                  duration: const Duration(microseconds: 300) ,
                  curve: Curves.linear,
              );
            }
          },
        backgroundColor: Colors.transparent,
        child: const Icon(
          Icons.arrow_circle_right, color: Colors.white,
          size: 50,
        ),

      ),
    );
  }
}

List<OnBoardingModel> splashes = [
  OnBoardingModel(
      'assets/food_beverage.json',
      'Choose your craving',
      'Get tasty succulent foods \nwith minty beverages',
      ),
  OnBoardingModel(
      'assets/order.json',
      'Place the order',
      'We got your food!'),
  OnBoardingModel(
      'assets/delivery.json',
      'On your door',
      'We travel through portals xD'),
];



