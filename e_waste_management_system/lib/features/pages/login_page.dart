import 'package:e_waste_management_system/features/widgets/header_text.dart';
import 'package:flutter/material.dart';
import '../auth/login.dart';
import '../widgets/icon_btn.dart';
import '../widgets/form_button.dart';
import '../widgets/curved_second.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffd6f22),
        leading: IconBtn(onPressed: () => Navigator.pop(context)),
      ),
      backgroundColor: Color(0xfffd6f22),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              // ← added
              clipper: CurvedClipper(), // ← added
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HeaderText("Login Here"),
                      SizedBox(height: 20),
                      LoginForm(),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.popAndPushNamed(
                                context,
                                '/forgot-password',
                              );
                            },
                            child: Text(
                              "Forgot password",
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 100),
                      FormButton(true, "Login", onPressed: () {}),
                    ],
                  ),
                ),
              ),
            ), // ← added
          ),
        ],
      ),
    );
  }
}
