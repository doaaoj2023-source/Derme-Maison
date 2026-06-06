import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/product_model.dart';
import '../screens/product_details_page.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? "guest";

    final favRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .doc(product.id);

    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(product.id);

    return StreamBuilder<DocumentSnapshot>(
      stream: favRef.snapshots(),
      builder: (context, favSnap) {
        final isFav = favSnap.hasData && favSnap.data!.exists;

        return StreamBuilder<DocumentSnapshot>(
          stream: cartRef.snapshots(),
          builder: (context, cartSnap) {
            final isInCart = cartSnap.hasData && cartSnap.data!.exists;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailsPage(product: product),
                  ),
                );
              },

              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 14),
                height: 240,

                child: Stack(
                  children: [

                    /// ================= BACKGROUND IMAGE =================
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Image.asset(
                          product.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    /// ================= DARK + GOLD LAYER =================
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.85),
                                Colors.black.withOpacity(0.2),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// ================= CATEGORY =================
                    Positioned(
                      top: 14,
                      left: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFC6A77D),
                          ),
                        ),
                        child: Text(
                          product.category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    /// ================= FAVORITE =================
                    Positioned(
                      top: 14,
                      right: 14,
                      child: GestureDetector(
                        onTap: () async {
                          if (isFav) {
                            await favRef.delete();
                          } else {
                            await favRef.set({
                              'id': product.id,
                              'name': product.name,
                              'image': product.image,
                              'price': product.price,
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.15),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.redAccent : Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),

                    /// ================= BOTTOM CONTENT =================
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// NAME
                          Text(
                            product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          /// DESCRIPTION (IMPORTANT ADDITION)
                          Text(
                            product.description.isEmpty
                                ? "Premium quality product for your beauty routine"
                                : product.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.75),
                              fontSize: 12,
                              height: 1.3,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Row(
                            children: [

                              /// PRICE
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC6A77D),
                                  borderRadius: BorderRadius.circular(22),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 10,
                                    )
                                  ],
                                ),
                                child: Text(
                                  "\$${product.price} ",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              const Spacer(),

                              /// CART BUTTON
                              GestureDetector(
                                onTap: () async {
                                  if (isInCart) {
                                    await cartRef.delete();
                                  } else {
                                    await cartRef.set({
                                      'id': product.id,
                                      'name': product.name,
                                      'image': product.image,
                                      'price': product.price,
                                      'qty': 1,
                                    });
                                  }
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isInCart
                                        ? Colors.greenAccent
                                        : const Color(0xFFC6A77D),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 12,
                                      )
                                    ],
                                  ),
                                  child: Icon(
                                    isInCart
                                        ? Icons.check
                                        : Icons.add_shopping_cart,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}