import 'package:flutter/material.dart';
import 'package:leetlab/ui/auth/login_screen.dart';
import 'package:leetlab/ui/widgets/buttons/leet_lab_elevated_button.dart';
import 'package:leetlab/ui/widgets/buttons/leet_lab_text_button.dart';
import 'package:leetlab/ui/widgets/custom_textfield.dart';
import 'package:leetlab/ui/widgets/glass_morphism.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  void _register() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful 🎉')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/icon/logo_with_name.png",
                height: size.height * 0.2,
              ),
              GlassMorphism(
                blurSigma: 100,
                opacity: 0.15,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Welcome to LeetLab'),
                        const SizedBox(height: 25),

                        // 👤 Username Field
                        buildTextField(
                          controller: _usernameController,
                          label: 'Full Name',
                          icon: Icons.person,
                          validator: (value) =>
                              value!.isEmpty ? 'Enter your username' : null,
                        ),
                        const SizedBox(height: 16),

                        // 📧 Email Field
                        buildTextField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Icons.email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your email';
                            } else if (!value.contains('@')) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // 🔒 Password Field
                        buildTextField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock,
                          obscureText: true,
                          validator: (value) =>
                              value!.length < 6 ? 'Password too short' : null,
                        ),
                        const SizedBox(height: 25),

                        // 🚀 Register Button
                        LeetLabElevatedButton(
                          text: "Register",
                          // size: 100,
                          isLoading: _isLoading,
                          onPressed: _register,
                        ),

                        const SizedBox(height: 20),

                        // 🔁 Login Redirect
                        LeetLabLinkButton(
                          message: "Already have an account?",
                          link: "Log in",
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
