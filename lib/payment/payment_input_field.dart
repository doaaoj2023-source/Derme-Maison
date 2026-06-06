import 'package:flutter/material.dart';

class PaymentInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLength;
  final bool isNumber;
  final VoidCallback onChanged;

  const PaymentInputField({
    super.key,
    required this.controller,
    required this.hint,
    required this.maxLength,
    required this.onChanged,
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLength: maxLength,
        keyboardType:
            isNumber ? TextInputType.number : TextInputType.text,
        onChanged: (_) => onChanged(),
        decoration: InputDecoration(
          counterText: "",
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}