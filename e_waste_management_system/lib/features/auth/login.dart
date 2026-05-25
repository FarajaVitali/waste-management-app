import 'package:flutter/material.dart';
import '../widgets/form_input.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          FormInput("Email"),
          SizedBox(height: 20),
          FormInput("Password"),
        ],
      ),
    );
  }
}
