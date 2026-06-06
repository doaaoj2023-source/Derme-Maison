import 'package:flutter/material.dart';
import '../widgets/main_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final PageController controller = PageController();

  void onTap(int index) {
    setState(() => currentIndex = index);

    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // 🔥 مهم
      extendBody: true,
      extendBodyBehindAppBar: true,

      body: Stack(
        children: [

          // 📱 الصفحات
          PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            children: const [
              Center(child: Text("Shop")),
              Center(child: Text("Cart")),
              Center(child: Text("Favorites")),
              Center(child: Text("Profile")),
            ],
          ),

          // 🧊 Navbar
          Align(
            alignment: Alignment.bottomCenter,
            child: MainNavigationBar(
              currentIndex: currentIndex,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}