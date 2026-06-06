import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './loginn/login_controller.dart';
import './loginn/login_form.dart';
import 'store.dart';

import '../widgets/favorites_background.dart';
import '../utils/app_colors.dart';
import './checkout/app_snackbar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final controller = AuthController();

  bool isLogin = true;
  bool isLoading = false;

  Future<void> submit() async {
    setState(() => isLoading = true);

    try {
      if (isLogin) {
        await controller.login(
          emailController.text,
          passwordController.text,
        );

        if (!mounted) return;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const StoreScreen()),
          (route) => false,
        );
      } else {
        await controller.signup(
          emailController.text,
          passwordController.text,
          nameController.text,
        );

        if (!mounted) return;

        AppSnackBar.show(context, "Account created successfully");

        setState(() => isLogin = true);
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      AppSnackBar.show(context, e.message ?? "Auth error");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> googleLogin() async {
    setState(() => isLoading = true);

    try {
      await controller.signInWithGoogle();

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const StoreScreen()),
        (route) => false,
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void goBack() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const StoreScreen()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.gold),
          onPressed: goBack,
        ),
      ),

      body: Stack(
        children: [
          const Positioned.fill(child: FavoritesBackground()),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const SizedBox(height: 10),

                  Text(
                    isLogin ? "WELCOME BACK" : "SIGN UP",
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: AppColors.gold,
                      letterSpacing: 3,
                    ),
                  ),

                  const SizedBox(height: 30),

                  AuthForm(
                    emailController: emailController,
                    passwordController: passwordController,
                    nameController: nameController,
                    isLogin: isLogin,
                    isLoading: isLoading,
                    onSubmit: submit,
                    onGoogle: googleLogin,
                  ),

                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: () {
                      setState(() => isLogin = !isLogin);
                    },
                    child: Text(
                      isLogin
                          ? "Don't have an account? Sign up"
                          : "Already have an account? Login",
                      style: const TextStyle(
                        color: AppColors.gold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthPage();
  }
}