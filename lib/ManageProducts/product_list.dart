import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/admin_product_model.dart';
import '../../services/product_admin_service.dart';
import '../ManageProducts/widgets/product_tile.dart';

class ProductList extends StatelessWidget {
  final Function(BuildContext, AdminProductModel) openEdit;

  const ProductList({
    super.key,
    required this.openEdit,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
    );
  }
}