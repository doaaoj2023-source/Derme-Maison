import 'package:flutter/material.dart';

class FavoriteEmptyWidget extends StatelessWidget {
  const FavoriteEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No favorites yet"),
    );
  }
}