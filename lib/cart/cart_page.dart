import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../cart/cart_service.dart';
import '../services/product_service.dart';
import '../models/product_model.dart';
import '../utils/product_images.dart';

import '../cart/cart_item_widget.dart';
import '../cart/login_required_card.dart';
import '../cart/checkout_bar.dart';

import '../screens/product_details_page.dart';
import '../widgets/favorites_background.dart';

import '../utils/app_colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: LoginRequiredCard(),
      );
    }

    final uid = user.uid;

    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "YOUR COLLECTION",
          style: TextStyle(
            letterSpacing: 4,
            fontWeight: FontWeight.w900,
            color: AppColors.appBarTitle,
          ),
        ),
      ),

      body: FavoritesBackground(
        child: StreamBuilder(
          stream: CartService.getCart(uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final cartDocs = snapshot.data!.docs;

            if (cartDocs.isEmpty) {
              return const Center(
                child: Text(
                  "Your collection is empty",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }

            double total = 0;

            for (final doc in cartDocs) {
              final data = doc.data() as Map<String, dynamic>;
              total += (data['price'] ?? 0) * (data['qty'] ?? 1);
            }

            return Column(
              children: [
                /// HERO SUMMARY
                Container(
                  margin: const EdgeInsets.all(14),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: AppColors.heroCardBg,
                    border: Border.all(color: AppColors.heroBorder),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.heroShadow,
                        blurRadius: 30,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.shopping_bag_outlined,
                        color: AppColors.gold,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${cartDocs.length} PIECES",
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.pieceText,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "\$${total.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: AppColors.pieceText,
                        ),
                      ),
                    ],
                  ),
                ),

                /// LIST
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 110),
                    itemCount: cartDocs.length,
                    itemBuilder: (context, index) {
                      final cart = cartDocs[index];

                      final productId = cart['id'];
                      final qty = cart['qty'] ?? 1;

                      return StreamBuilder(
                        stream: ProductService.streamProduct(productId),
                        builder: (context, productSnap) {
                          if (!productSnap.hasData ||
                              !productSnap.data!.exists ||
                              productSnap.data!.data() == null) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: AppColors.heroCardBg,
                              ),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "This item is no longer available",
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: AppColors.dangerRed,
                                    ),
                                    onPressed: () {
                                      CartService.removeItem(uid, productId);
                                    },
                                  ),
                                ],
                              ),
                            );
                          }

                          final data = productSnap.data!.data()
                              as Map<String, dynamic>;

                          final product = ProductModel(
                            id: productId,
                            name: data['name'] ?? "",
                            image: ProductImages.getImage(
                              (data['imageKey'] ?? data['category'] ?? "")
                                  .toString(),
                            ),
                            price: (data['price'] ?? 0).toDouble(),
                            category: data['category'] ?? "",
                            description: data['description'] ?? "",
                            cartQty: qty,
                          );

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ProductDetailsPage(product: product),
                                ),
                              );
                            },
                            child: CartItemWidget(
                              product: product,
                              onAdd: () => CartService.updateQty(
                                uid,
                                productId,
                                qty + 1,
                              ),
                              onRemove: () {
                                if (qty <= 1) {
                                  CartService.removeItem(uid, productId);
                                } else {
                                  CartService.updateQty(
                                    uid,
                                    productId,
                                    qty - 1,
                                  );
                                }
                              },
                              onDelete: () =>
                                  CartService.removeItem(uid, productId),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                /// CHECKOUT
                SafeArea(
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    child: CheckoutBar(total: total),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}