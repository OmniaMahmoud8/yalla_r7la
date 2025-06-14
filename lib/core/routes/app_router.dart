// core/routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:yalla_r7la_new/pages/PersonalInformationPage.dart';
import 'package:yalla_r7la_new/pages/onboardingScreen1.dart';
import 'package:yalla_r7la_new/pages/EditInformationPage.dart';

class AppRoutes {
  static const String onboarding1 = '/';
  static const String information = '/information';
  static const String personalInformation = '/personal-info';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboarding1:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen1());

      case AppRoutes.information:
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => EditInformationPage(
            name: args['name'] ?? '',
            email: args['email'] ?? '',
            phone: args['phone'] ?? '',
            birthDate: '',
            profilePicture: '',
            gender: '',
          ),
        );

      case AppRoutes.personalInformation:
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => PersonalInformationPage(
            email: args['email'] ?? '',
            phone: args['phone'] ?? '',
            firstName: '',
            lastName: '',
            userName: '',
            birthDate: '',
            gender: '',
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No route defined'))),
        );
    }
  }
}
