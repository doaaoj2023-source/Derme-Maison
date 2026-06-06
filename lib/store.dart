import 'package:flutter/material.dart';

import 'screens/shop_page.dart';
import 'screens/profile_page.dart';
import 'cart/cart_page.dart';
import 'favorites/favorite_page.dart';

import 'home/home_page.dart';

import 'widgets/main_navigation_bar.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  int index = 0;

  final List<Widget> pages = [
    HomePage(),
    const ShopPage(),
    const CartPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF7F3EE),

      body: IndexedStack(
        index: index,
        children: pages,
      ),

      bottomNavigationBar: MainNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
      ),
    );
  }
}