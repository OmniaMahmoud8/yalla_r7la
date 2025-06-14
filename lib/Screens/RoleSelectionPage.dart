// Screens/RoleSelectionPage.dart
import 'package:flutter/material.dart';
import 'package:yalla_r7la_new/pages/sign_in.dart';
import 'package:yalla_r7la_new/Screens/sign_in_admin.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 207, 221, 192),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/group_39.png',
                  height: 220,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 40),

              const Text(
                "Choose your role",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 52, 58, 53),
                ),
              ),
              const SizedBox(height: 12),
              const Spacer(),
              Column(
                children: [
                  CustomWideButton(
                    label: "Admin",
                    color: const Color.fromARGB(255, 101, 130, 105),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignIn1(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomWideButton(
                    label: "Business",
                    color: const Color.fromARGB(255, 101, 130, 105),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignIn()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomWideButton(
                    label: "User",
                    color: const Color.fromARGB(255, 101, 130, 105),
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomWideButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color color;

  const CustomWideButton({
    super.key,
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 3,
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        child: Text(label),
      ),
    );
  }
}
