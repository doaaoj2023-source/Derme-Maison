import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../screens/product_details_page.dart';

class FavoriteItemWidget extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onDelete;

  const FavoriteItemWidget({
    super.key,
    required this.product,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
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
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        height: 190, //  أكبر شوية عشان المحتوى

        child: Stack(
          children: [

            /// (HERO STYLE)
            ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: Stack(
                children: [

                  Positioned.fill(
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// DARK OVERLAY FOR TEXT
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.65),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///  BORDER EFFECT
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.15),
                  ),
                ),
              ),
            ),

            ///  CONTENT (NAME + PRICE + DESCRIPTION)
            Positioned(
              left: 16,
              right: 16,
              bottom: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [

                  /// NAME
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// DESCRIPTION
                  Text(
                    product.description.isNotEmpty
                        ? product.description
                        : "Premium product",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 12,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      /// PRICE 
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC6A77D),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          "\$${product.price.toStringAsFixed(2)} ",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const Spacer(),

                      /// DELETE BUTTON
                      GestureDetector(
                        onTap: onDelete,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.35),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                            size: 20,
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
  }
}