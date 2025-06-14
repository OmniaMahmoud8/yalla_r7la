// main.dart
import 'package:flutter/material.dart';
import 'package:yalla_r7la_new/pages/onboardingScreen1.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const YallaR7la());
  FlutterNativeSplash.remove();
}

class YallaR7la extends StatelessWidget {
  const YallaR7la({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen1(),
    );
  }
}
