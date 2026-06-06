import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/shop_app_bar.dart';
import '../widgets/shop_banner_slider.dart';
import '../widgets/shop_search_filter.dart';
import '../widgets/product_card.dart';
import '../Component/luxury_background.dart';

import '../models/product_model.dart';
import '../store.dart';
import '../utils/product_images.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String search = "";
  String selectedFilter = "All";
  bool productsLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,

      appBar: ShopAppBar(
        onBack: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const StoreScreen()),
            (route) => false,
          );
        },
        onCartTap: () {},
      ),

      body: LuxuryBackground(
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('products')
                .orderBy('createdAt', descending: true)
                .snapshots(),

            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData) {
                return const Center(child: Text("No products found"));
              }

              final products = snapshot.data!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;

                return ProductModel(
                  id: doc.id,
                  name: data['name'] ?? '',
                  price: (data['price'] ?? 0).toDouble(),
                  image: ProductImages.getImage(data['imageKey'] ?? ''),
                  category: data['category'] ?? 'All',
                  description: data['description'] ?? '',
                  isFavorite: false,
                  cartQty: 0,
                );
              }).toList();

              final filtered = products.where((p) {
                final matchSearch = p.name
                    .toLowerCase()
                    .contains(search.toLowerCase());

                final matchFilter =
                    selectedFilter == "All" ||
                    p.category == selectedFilter;

                return matchSearch && matchFilter;
              }).toList();

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    const ShopBannerSlider(),

                    const SizedBox(height: 15),

                    ShopSearchFilter(
                      search: search,
                      selectedFilter: selectedFilter,
                      onSearchChanged: (v) =>
                          setState(() => search = v),
                      onFilterChanged: (v) =>
                          setState(() => selectedFilter = v),
                    ),

                    const SizedBox(height: 15),

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      itemCount: filtered.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.72,
                      ),
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: filtered[index],
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}