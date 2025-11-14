import 'package:flutter/material.dart';
import 'package:leetlab/ui/auth/register_screen.dart';
import 'package:leetlab/ui/widgets/buttons/leet_lab_elevated_button.dart';
import 'package:leetlab/ui/widgets/buttons/leet_lab_text_button.dart';
import 'package:leetlab/ui/widgets/custom_textfield.dart';
import 'package:leetlab/ui/widgets/glass_morphism.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _rememberMe = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login successful ✅')));
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
                        const Text('Welcome Back to LeetLab'),
                        const SizedBox(height: 25),

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

                        buildTextField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock,
                          obscureText: true,
                          validator: (value) =>
                              value!.length < 6 ? 'Password too short' : null,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (val) {
                                    setState(() => _rememberMe = val!);
                                  },
                                  side: BorderSide(width: 2),
                                ),
                                const Text("Remember me"),
                              ],
                            ),
                            LeetLabLinkButton(
                              message: "",
                              link: "Forgot Password?",
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Forgot Password clicked 🔑'),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),

                        LeetLabElevatedButton(
                          text: "Log In",
                          // size: 100,
                          isLoading: _isLoading,
                          onPressed: _login,
                        ),

                        const SizedBox(height: 20),

                        LeetLabLinkButton(
                          message: "Don’t have an account?",
                          link: "Register",
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
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
