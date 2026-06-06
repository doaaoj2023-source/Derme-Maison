import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../utils/app_colors.dart';

class ProductBottomSheet extends StatelessWidget {
  final ProductModel product;

  final int quantity;
  final bool isFav;
  final double sheetOffset;

  final VoidCallback onFav;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onDragEnd;
  final VoidCallback onTap;

  const ProductBottomSheet({
    super.key,
    required this.product,
    required this.quantity,
    required this.isFav,
    required this.sheetOffset,
    required this.onFav,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDragEnd,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      bottom: -sheetOffset,
      left: 0,
      right: 0,
      child: GestureDetector(
        onVerticalDragEnd: (_) => onDragEnd(),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(35),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(22, 14, 22, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// HANDLE
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              /// PRODUCT NAME
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 8),

              /// DESCRIPTION
              Text(
                product.description,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: AppColors.mutedText,
                ),
              ),

              const SizedBox(height: 16),

              /// PRICE
              Text(
                "\$${product.price}",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gold,
                ),
              ),

              const SizedBox(height: 18),

              /// FAVORITE
              Container(
                decoration: BoxDecoration(
                  color: AppColors.dangerRedSoft.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.favorite_border,
                    color: AppColors.dangerRedSoft,
                  ),
                  title: const Text("Add to Wishlist"),
                  trailing: Icon(
                    isFav
                        ? Icons.check_circle
                        : Icons.add_circle_outline,
                    color: AppColors.dangerRedSoft,
                  ),
                  onTap: onFav,
                ),
              ),

              const SizedBox(height: 12),

              /// QUANTITY
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.bg1,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Text(
                      "Quantity",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const Spacer(),

                    IconButton(
                      onPressed: onDecrease,
                      icon: const Icon(
                        Icons.remove_circle_outline,
                      ),
                    ),

                    Text(
                      "$quantity",
                      style: const TextStyle(fontSize: 16),
                    ),

                    IconButton(
                      onPressed: onIncrease,
                      icon: const Icon(
                        Icons.add_circle_outline,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              /// CART BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryButton,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Add to Bag • $quantity item(s)",
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.whiteText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}