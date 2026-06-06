import 'package:flutter/material.dart';

class FavoriteDeletedCard extends StatelessWidget {
  final VoidCallback onRemove;

  const FavoriteDeletedCard({
    super.key,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.info, color: Colors.grey),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              "Product deleted by admin",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: onRemove,
            child: const Text("Remove"),
          ),
        ],
      ),
    );
  }
}