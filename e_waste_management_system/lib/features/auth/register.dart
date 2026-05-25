import 'package:e_waste_management_system/services/auth_services.dart';
import 'package:flutter/material.dart';
import '../widgets/form_input.dart';
import '../widgets/form_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  Future<void> _onRegister() async {
    if (formKey.currentState!.validate()) {
      final success = await AuthServices.register(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        passwordConfirm: _confirmPassController.text,
      );
      if (success) {
        formKey.currentState!.reset();
        _firstNameController.clear();
        _lastNameController.clear();
        _emailController.clear();
        _passwordController.clear();
        _confirmPassController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          FormInput("First Name", controller: _firstNameController),
          SizedBox(height: 20),
          FormInput("Last Name", controller: _lastNameController),
          SizedBox(height: 20),
          FormInput("Email", controller: _emailController),
          SizedBox(height: 20),
          FormInput(
            "Password",
            controller: _passwordController,
            isPassword: true,
          ),
          SizedBox(height: 20),
          FormInput(
            "Confirm Password",
            controller: _confirmPassController,
            isPassword: true,
          ),
          SizedBox(height: 20),
          FormButton(true, "Register", onPressed: _onRegister),
        ],
      ),
    );
  }
}
