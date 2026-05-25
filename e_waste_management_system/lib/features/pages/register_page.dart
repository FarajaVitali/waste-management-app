import 'package:e_waste_management_system/features/widgets/header_text.dart';
import 'package:flutter/material.dart';
import '../auth/register.dart';
import '../widgets/icon_btn.dart';
import '../widgets/curved_second.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HeaderText("Register Here"),
                      SizedBox(height: 20),
                      RegisterForm(),
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
