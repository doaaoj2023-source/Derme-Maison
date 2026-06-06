import 'package:flutter/material.dart';

class ProductTopActions extends StatelessWidget {
  final bool isFav;
  final VoidCallback onFav;
  final VoidCallback onBack;

  const ProductTopActions({
    super.key,
    required this.isFav,
    required this.onFav,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 10,
      right: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          /// BACK
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 16),
              onPressed: onBack,
            ),
          ),

          /// FAVORITE
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: Colors.redAccent,
              ),
              onPressed: onFav,
            ),
          ),
        ],
      ),
    );
  }
}