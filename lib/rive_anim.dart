

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
    final riveOnboard = await rootBundle.load('assets/rive_onboarding.riv');
    final file = RiveFile.import(riveOnboard);
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
  // late ByteData riveOnboard;
  // late RiveFile file;
  // final riveController = RiveWidgetController();
  var currentIndex= 0;
  final _pageController = PageController();
  late RiveAnimation animation;
  late StateMachineController stateMachineController;
  //SMINumber? _transitionInput;
  List<SMITrigger> triggerInput =[];

  @override
  void initState(){
    super.initState();
    getStateMachinesNames();
    animation = RiveAnimation.asset(
      'assets/rive_onboarding.riv',
      artboard: 'Artboard',
      fit: BoxFit.contain,
      onInit: onRiveInit,
    );
  }

  void onRiveInit(Artboard artboard){
    stateMachineController = StateMachineController.fromArtboard(artboard,'State Machine')!;
    artboard.addController(stateMachineController);
    final stateMachine = stateMachineController.stateMachine;
    print('State Machine name : ${stateMachine.name}');
    for(final trigger in stateMachine.inputs){
      print('input exist?:${trigger.name}');
      if(trigger.name=='Screen Number'){
        continue;
      }
      triggerInput.add(stateMachineController.findInput<bool>(trigger.name) as SMITrigger);
    }
    // triggerInput.add(stateMachineController.findInput<bool>('1st Screen Trigger') as SMITrigger);
    // triggerInput.add(stateMachineController.findInput<bool>('2nd Screen Trigger') as SMITrigger);
    // triggerInput.add(stateMachineController.findInput<bool>('3rd Screen Trigger') as SMITrigger);
    // triggerInput.add(stateMachineController.findInput<bool>('4th Screen Trigger') as SMITrigger);
    //_transitionInput = stateMachineController.findInput<double>('Number of Rooms') as SMINumber?;
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
                child: animation,
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
                      controller: _pageController,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index){
                        //String building = buildings[index];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Transition',
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
                          currentIndex =value-1;
                          print(value);
                          print(triggerInput[currentIndex].name);
                          triggerInput[currentIndex].fire();
                         // _transitionInput?.value = value.toDouble();
                        });
                      },

                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int index = 0; index < 5; index++)
                        DotIndicator(isSelected: index == currentIndex ),
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

//List<String> buildings=['Start','2 storied','3 storied','4 storied','5 storied','6 storied','7 storied'];
