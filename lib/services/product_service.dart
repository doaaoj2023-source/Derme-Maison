import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  static Stream<DocumentSnapshot> streamProduct(String id) {
    return FirebaseFirestore.instance
        .collection('products')
        .doc(id)
        .snapshots();
  }
}