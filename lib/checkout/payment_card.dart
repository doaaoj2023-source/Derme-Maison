import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final Color color;

  const PaymentCard({
    super.key,
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.15) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? color : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? color : Colors.grey),
            const SizedBox(width: 12),
            Text(title),
            const Spacer(),
            Icon(
              selected ? Icons.check_circle : Icons.radio_button_off,
              color: selected ? color : Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}