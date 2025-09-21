import 'package:flutter/material.dart';
import 'onboarding/onboarding_screen.dart';
import 'package:rive/rive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black38),
      ),
      home: const MyRiveAnimation(),
    );
  }
}

class MyRiveAnimation extends StatelessWidget {
  const MyRiveAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RiveAnimation.asset('assets/onboarding_animation01.riv'),
      ),
    );
  }
}
