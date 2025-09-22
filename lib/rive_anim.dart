

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

import 'onboarding/dotindicator.dart';

class MyRiveAnimation extends StatefulWidget {
  const MyRiveAnimation({super.key});

  @override
  State<MyRiveAnimation> createState() => _MyRiveAnimationState();
}

class _MyRiveAnimationState extends State<MyRiveAnimation> {
  //final RiveAnimationController _controller = SimpleAnimation('Animation');
  void getStateMachinesNames() async{
    final byte = await rootBundle.load('assets/apartment.riv');
    final file = RiveFile.import(byte);
    bool isInputPresent = false;
    final artBoard = file.mainArtboard;
    for(final controller in artBoard.stateMachines){
      print('State Machine exist: ${controller.name}');
      for(final input in controller.inputs){
        isInputPresent = true;
        print('Input Name:${input.name}');
      }
      print('input exist?:$isInputPresent');
    }
  }
  final _pageController = PageController();
  late RiveAnimation animation;
  late StateMachineController stateMachineController;
  SMINumber? _transitionInput;

  @override
  void initState(){
    super.initState();
    getStateMachinesNames();
    animation = RiveAnimation.asset(
      'assets/apartment.riv',
      artboard: 'Artboard',
      fit: BoxFit.contain,
      onInit: onRiveInit,
    );
  }

  void onRiveInit(Artboard artboard){
    stateMachineController = StateMachineController.fromArtboard(artboard,'Houses')!;
    artboard.addController(stateMachineController);
    _transitionInput = stateMachineController.findInput<double>('Number of Rooms') as SMINumber?;
  }

  @override
  void dispose(){
    stateMachineController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 10,
            right: 0,
            left: 0,
            bottom: 20,
            child: Transform.scale(
                scale: 1,
                child: animation),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 270,
              child: Column(
                children: [
                  Flexible(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: buildings.length,
                      itemBuilder: (BuildContext context, int index){
                        String building = buildings[index];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(building,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                      onPageChanged: (value){
                        setState(() {
                          _transitionInput?.value = value.toDouble();
                        });
                      },

                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int index = 0; index < buildings.length; index++)
                        DotIndicator(isSelected: index == _transitionInput?.value.toInt() ),
                    ],
                  ),
                  const SizedBox(height: 75),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<String> buildings=['Start','2 storied','3 storied','4 storied','5 storied','6 storied','7 storied'];
