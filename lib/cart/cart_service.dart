import 'package:cloud_firestore/cloud_firestore.dart';

class CartService {
  static Stream<QuerySnapshot> getCart(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart')
        .snapshots();
  }

  static Future<void> updateQty(
      String uid, String productId, int qty) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(productId)
        .update({'qty': qty});
  }

  static Future<void> removeItem(
      String uid, String productId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(productId)
        .delete();
  }
}