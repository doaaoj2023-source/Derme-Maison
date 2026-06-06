import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  final String userId = "USER_ID"; // لاحقاً بدله بـ FirebaseAuth

  // ================= SET PRODUCTS =================
  void setProducts(List<ProductModel> list) {
    _products = list;
    notifyListeners();
  }

  // ================= CART COUNT =================
  int get cartCount {
    return _products.fold(0, (sum, item) => sum + item.cartQty);
  }

  // ================= FAVORITE =================
  Future<void> toggleFavorite(String productId) async {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index == -1) return;

    _products[index].isFavorite = !_products[index].isFavorite;
    notifyListeners();

    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(productId);

    if (_products[index].isFavorite) {
      await ref.set({
        'id': productId,
        'name': _products[index].name,
        'image': _products[index].image,
        'price': _products[index].price,
      });
    } else {
      await ref.delete();
    }
  }

  // ================= ADD TO CART =================
  Future<void> addToCart(String productId) async {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index == -1) return;

    _products[index].cartQty++;
    notifyListeners();

    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId);

    await ref.set({
      'id': productId,
      'name': _products[index].name,
      'image': _products[index].image,
      'price': _products[index].price,
      'qty': _products[index].cartQty,
    }, SetOptions(merge: true));
  }

  // ================= REMOVE FROM CART =================
  Future<void> removeFromCart(String productId) async {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index == -1) return;

    if (_products[index].cartQty > 0) {
      _products[index].cartQty--;
    }

    notifyListeners();

    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId);

    if (_products[index].cartQty <= 0) {
      await ref.delete();
    } else {
      await ref.update({'qty': _products[index].cartQty});
    }
  }
}