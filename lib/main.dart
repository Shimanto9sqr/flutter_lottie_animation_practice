import 'package:flutter/material.dart';
import 'package:lottie_animation/rive_anim.dart';
import 'package:rive/rive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RiveFile.initialize();
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
      home:  MyRiveAnimation(),
    );
  }
}

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Transform.scale(
//             scale: 1.5,
//             child: MyRiveAnimation(),
//           ),
//         ],
//       ),
//     );
//   }
// }

