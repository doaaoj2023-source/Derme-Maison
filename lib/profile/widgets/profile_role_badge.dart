import 'package:flutter/material.dart';

class ProfileRoleBadge extends StatelessWidget {
  final String role;

  const ProfileRoleBadge({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: role == 'admin'
            ? Colors.orange
            : Colors.green,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        role.toUpperCase(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}