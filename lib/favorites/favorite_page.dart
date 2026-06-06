import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/product_model.dart';
import '../utils/product_images.dart';
import '../favorites/services/favorites_service.dart';
import '../favorites/widgets/favorite_item_card.dart';
import '../widgets/favorites_background.dart';
import '../utils/app_colors.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Please login")),
      );
    }

    final uid = user.uid;

    return Scaffold(
      backgroundColor: Colors.transparent,

      /// APP BAR (ONLY COLOR CLEANUP)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "MY FAVORITES",
          style: TextStyle(
            letterSpacing: 4,
            fontWeight: FontWeight.w900,
            color: AppColors.gold.withOpacity(0.9),
          ),
        ),
      ),

      body: Stack(
        children: [

          /// BACKGROUND
          const FavoritesBackground(),

          /// CONTENT (UNCHANGED LOGIC)
          StreamBuilder(
            stream: FavoritesService.getFavorites(uid),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final docs = snapshot.data!.docs;

              if (docs.isEmpty) {
                return Center(
                  child: Text(
                    "Your favorites is empty",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.mutedText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 30),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final fav = docs[index].data() as Map<String, dynamic>;
                  final id = fav['id'];

                  return StreamBuilder(
                    stream: FavoritesService.streamProduct(id),
                    builder: (context, productSnap) {

                      /// PRODUCT DELETED STATE (UNCHANGED)
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
                            color: Colors.white.withOpacity(0.45),
                          ),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "This product is no longer available",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: AppColors.dangerRed,
                                ),
                                onPressed: () {
                                  FavoritesService.removeFavorite(uid, id);
                                },
                              ),
                            ],
                          ),
                        );
                      }

                      final data =
                          productSnap.data!.data() as Map<String, dynamic>;

                      final product = ProductModel(
                        id: id,
                        name: data['name'] ?? "",
                        image: ProductImages.getImage(
                          (data['imageKey'] ?? data['category'] ?? "")
                              .toString(),
                        ),
                        price: (data['price'] ?? 0).toDouble(),
                        category: data['category'] ?? "",
                        description: data['description'] ?? "",
                        isFavorite: true,
                        cartQty: 0,
                      );

                      return FavoriteItemWidget(
                        product: product,
                        onDelete: () =>
                            FavoritesService.removeFavorite(uid, id),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}