import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesService {
  static Stream<QuerySnapshot> getFavorites(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .snapshots();
  }

  static Stream<DocumentSnapshot> streamProduct(String id) {
    return FirebaseFirestore.instance
        .collection('products')
        .doc(id)
        .snapshots();
  }

  static Future<void> removeFavorite(String uid, String id) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .doc(id)
        .delete();
  }
}