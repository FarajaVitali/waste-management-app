import 'package:flutter/material.dart';
import '../widgets/header_text.dart';
import '../widgets/normal_text.dart';
import '../widgets/button.dart';
import '../widgets/curved_clipper.dart';
import '../pages/register_page.dart';
import '../pages/login_page.dart';

class StartupPage extends StatelessWidget {
  const StartupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffd6f22),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.recycling, size: 100, color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    'E-Waste Collector',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Curved white bottom section ──────────────────
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: CurvedClipper(), // ← used from separate file
              child: Container(
                height: 460,
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 60, 28, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HeaderText("WELCOME"),
                      SizedBox(height: 12),
                      NormalText(
                        "Welcome to the application. This app is "
                        "intended for E-Waste Collection on urban areas.",
                      ),
                      SizedBox(height: 36),

                      Button(
                        true,
                        "Log In",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 14),
                      Button(
                        false,
                        "Sign Up",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
