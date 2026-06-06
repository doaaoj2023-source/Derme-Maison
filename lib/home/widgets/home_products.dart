import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Component/luxury_background.dart';
import '../../Component/section_header.dart';

import '../../models/product_model.dart';
import '../../widgets/product_card.dart';
import '../../utils/product_images.dart';

class HomeProducts extends StatelessWidget {
  const HomeProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('products')
          .where('showInHome', isEqualTo: true)
          .snapshots(),

      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 250,
            child: Center(child: CircularProgressIndicator()),
          );
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
          );
        }).toList();

        return LuxuryBackground(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(vertical: 26),

            child: Column(
              children: [

                const SectionHeader(
                  tag: "CURATED LUXURY",
                  title: "Featured Collection",
                  subtitle:
                      "A curated selection of premium beauty essentials designed for elegance, confidence & modern luxury.",
                ),

                const SizedBox(height: 22),

                SizedBox(
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    itemCount: products.length,
                    itemBuilder: (context, i) {
                      return Container(
                        width: 200,
                        margin: const EdgeInsets.only(right: 14),
                        child: ProductCard(product: products[i]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}