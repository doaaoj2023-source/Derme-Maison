import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  static final CollectionReference _ref =
      FirebaseFirestore.instance.collection('products');

  static Future<void> add(Map<String, dynamic> data) async {
    await _ref.add({
      ...data,
      'createdAt': DateTime.now(),
    });
  }

  static Future<void> update(String id, Map<String, dynamic> data) async {
    await _ref.doc(id).update(data);
  }

  static Future<void> delete(String id) async {
    await _ref.doc(id).delete();
  }
}