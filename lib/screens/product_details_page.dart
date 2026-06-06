import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import '../utils/product_images.dart';
import '../models/product_model.dart';
import '../widgets/product_image_section.dart';
import '../widgets/product_bottom_sheet.dart';
import '../widgets/product_top_actions.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  bool isMinimized = false;

  double get sheetOffset => isMinimized ? 140 : 0;
  double get imageScale => isMinimized ? 1.08 : 1.0;

  void resetSheet() => setState(() => isMinimized = false);
  void minimizeSheet() => setState(() => isMinimized = true);

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;
final String uid = user?.uid ?? 'guest';

final favRef = FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .collection('favorites')
    .doc(widget.product.id);

final cartRef = FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .collection('cart')
    .doc(widget.product.id);

    return StreamBuilder<DocumentSnapshot>(
      stream: favRef.snapshots(),
      builder: (context, favSnap) {

        final isFav = favSnap.hasData && favSnap.data!.exists;

        return StreamBuilder<DocumentSnapshot>(
          stream: cartRef.snapshots(),
          builder: (context, cartSnap) {

            final isInCart = cartSnap.hasData && cartSnap.data!.exists;

           int qty = 0;

if (cartSnap.hasData && cartSnap.data!.exists) {
  final data = cartSnap.data!.data() as Map<String, dynamic>;
  qty = data['qty'] ?? 1;
}

            return Scaffold(
              backgroundColor: const Color(0xFFF7F3EE),

              body: SafeArea(
                child: Stack(
                  children: [

                   ProductImageSection(
  image: widget.product.image,
  imageScale: imageScale,
),

                    ProductTopActions(
                      isFav: isFav,
                      onFav: () async {
                        if (isFav) {
                          await favRef.delete();
                        } else {
                          await favRef.set({
                            'id': widget.product.id,
                            'name': widget.product.name,
                            'image': widget.product.image,
                            'price': widget.product.price,
                          });
                        }
                      },
                      onBack: () => Navigator.pop(context),
                    ),

                    ProductBottomSheet(
                      product: widget.product,
                      quantity: qty,
                      isFav: isFav,
                      sheetOffset: sheetOffset,

                      onFav: () async {
                        if (isFav) {
                          await favRef.delete();
                        } else {
                          await favRef.set({
                            'id': widget.product.id,
                            'name': widget.product.name,
                            'image': widget.product.image,
                            'price': widget.product.price,
                          });
                        }
                      },

                      onIncrease: () async {
                        if (isInCart) {
                          await cartRef.update({'qty': qty + 1});
                        } else {
                          await cartRef.set({
                            'id': widget.product.id,
                            'name': widget.product.name,
                            'image': widget.product.image,
                            'price': widget.product.price,
                            'qty': 1,
                          });
                        }
                      },

                      onDecrease: () async {
                        if (!isInCart) return;

                        if (qty <= 1) {
                          await cartRef.delete();
                        } else {
                          await cartRef.update({'qty': qty - 1});
                        }
                      },

                      onDragEnd: minimizeSheet,
                      onTap: resetSheet,
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