import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../Component/app_button.dart';

class AuthForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? nameController;

  final bool isLogin;
  final bool isLoading;
  final VoidCallback onSubmit;
  final VoidCallback? onGoogle;

  const AuthForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    this.nameController,
    required this.isLogin,
    required this.isLoading,
    required this.onSubmit,
    this.onGoogle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        const SizedBox(height: 20),

        if (!isLogin)
          _field(
            controller: nameController!,
            hint: "Full Name",
            icon: Icons.person_outline,
          ),

        if (!isLogin) const SizedBox(height: 12),

        _field(
          controller: emailController,
          hint: "Email Address",
          icon: Icons.email_outlined,
        ),

        const SizedBox(height: 12),

        _field(
          controller: passwordController,
          hint: "Password",
          icon: Icons.lock_outline,
          obscure: true,
        ),

        const SizedBox(height: 20),

        AppButton(
          text: isLogin ? "LOGIN" : "CREATE ACCOUNT",
          onPressed: isLoading ? () {} : onSubmit,
          backgroundColor: AppColors.gold,
        ),

        const SizedBox(height: 15),

        if (isLogin && onGoogle != null)
          AppButton(
            text: "Continue with Google",
            icon: Image.network(
              "https://cdn-icons-png.flaticon.com/512/2991/2991148.png",
              width: 20,
              height: 20,
            ),
            backgroundColor: AppColors.softWhite,
            textColor: AppColors.darkText,
            onPressed: onGoogle!,
          ),
      ],
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.softWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(
          color: AppColors.darkText,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.softWhite,

          hintText: hint,
          hintStyle: const TextStyle(
            color: AppColors.mutedText,
          ),

          prefixIcon: Icon(
            icon,
            color: AppColors.gold,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.gold,
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}