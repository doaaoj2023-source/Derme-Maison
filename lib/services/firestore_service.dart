import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  // ================= FAVORITES =================
  static Stream<QuerySnapshot> getFavorites(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots();
  }

  static Future<void> toggleFavorite({
    required String userId,
    required String productId,
    required Map<String, dynamic> data,
  }) async {

    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(productId);

    final doc = await ref.get();

    if (doc.exists) {
      await ref.delete();
    } else {
      await ref.set(data);
    }
  }

  // ================= CART =================
  static Stream<QuerySnapshot> getCart(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .snapshots();
  }

  static Future<void> addToCart({
    required String userId,
    required String productId,
    required Map<String, dynamic> data,
  }) async {

    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId);

    final doc = await ref.get();

    if (doc.exists) {
      await ref.update({
        'qty': FieldValue.increment(1),
      });
    } else {
      await ref.set({
        ...data,
        'qty': 1,
      });
    }
  }

  static Future<void> updateCartQty({
    required String userId,
    required String productId,
    required int qty,
  }) async {

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId)
        .update({
      'qty': qty,
    });
  }

  static Future<void> removeFromCart({
    required String userId,
    required String productId,
  }) async {

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId)
        .delete();
  }
}