import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/admin_product_model.dart';
import '../services/product_admin_service.dart';
import '../dialogs/product_form_dialog.dart';

import '../ManageProducts/widgets/product_tile.dart';
import '../widgets/favorites_background.dart';

import '../utils/app_colors.dart';

class ManageProductsPage extends StatelessWidget {
  const ManageProductsPage({super.key});

  void openAdd(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => ProductFormDialog(
        title: "Add Product",
        buttonText: "Add",

        nameController: TextEditingController(),
        priceController: TextEditingController(),
        descriptionController: TextEditingController(),
        imageKeyController: TextEditingController(),

        selectedCategory: "Serum",
        showInHome: false,
      ),
    );
  }

  void openEdit(BuildContext context, AdminProductModel product) {
    showDialog(
      context: context,
      builder: (_) => ProductFormDialog(
        title: "Edit Product",
        buttonText: "Save",

        id: product.id,
        isEdit: true,

        nameController: TextEditingController(text: product.name),
        priceController: TextEditingController(text: product.price.toString()),
        descriptionController: TextEditingController(text: product.description),
        imageKeyController: TextEditingController(text: product.imageKey),

        selectedCategory: product.category,
        showInHome: product.showInHome,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,

        title: Text(
          "MANAGE PRODUCTS",
          style: TextStyle(
            letterSpacing: 3,
            fontWeight: FontWeight.w900,
            color: AppColors.gold,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => openAdd(context),
        backgroundColor: AppColors.gold,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: Stack(
        children: [
          /// BACKGROUND
          const Positioned.fill(
            child: FavoritesBackground(),
          ),

          /// CONTENT
          SafeArea(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),

              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.only(top: 20, bottom: 30),
                  itemCount: docs.length,
                  itemBuilder: (context, i) {
                    final data = docs[i].data() as Map<String, dynamic>;

                    final product = AdminProductModel.fromMap(
                      id: docs[i].id,
                      data: data,
                    );

                    return ProductTile(
                      product: product,
                      onEdit: () => openEdit(context, product),
                      onDelete: () => ProductService.delete(product.id),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}