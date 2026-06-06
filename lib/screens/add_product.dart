import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProductPage extends StatefulWidget {

  AddProductPage({super.key});

  @override
  State<AddProductPage> createState() =>
      _AddProductPageState();
}

class _AddProductPageState
    extends State<AddProductPage> {

  final nameController = TextEditingController();

  final priceController = TextEditingController();

  final descriptionController =
      TextEditingController();

  bool isLoading = false;

  Future<void> saveProduct() async {

    if (nameController.text.isEmpty ||
        priceController.text.isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      await FirebaseFirestore.instance
          .collection('products')
          .add({

        'name': nameController.text.trim(),

        'price': double.parse(
          priceController.text.trim(),
        ),

        'description':
            descriptionController.text.trim(),

        'category': 'All',

        'createdAt':
            FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            "Product Added",
          ),
        ),
      );

      Navigator.pop(context);

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text("$e"),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF6F1EB),

      appBar: AppBar(

        title: const Text("Add Product"),

        backgroundColor: Colors.transparent,

        elevation: 0,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: const Column(

                children: [

                  Icon(
                    Icons.image,
                    size: 45,
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Write product name exactly:\nshoe / bag / watch",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            TextField(

              controller: nameController,

              decoration: const InputDecoration(
                labelText: "Product Name",
              ),
            ),

            const SizedBox(height: 10),

            TextField(

              controller: priceController,

              keyboardType:
                  TextInputType.number,

              decoration: const InputDecoration(
                labelText: "Price",
              ),
            ),

            const SizedBox(height: 10),

            TextField(

              controller:
                  descriptionController,

              decoration: const InputDecoration(
                labelText: "Description",
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(

              width: double.infinity,

              height: 50,

              child: ElevatedButton(

                onPressed:
                    isLoading ? null : saveProduct,

                child: isLoading

                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )

                    : const Text(
                        "Save Product",
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}