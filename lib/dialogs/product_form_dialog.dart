import 'package:flutter/material.dart';
import '../services/product_admin_service.dart';

class ProductFormDialog extends StatefulWidget {
  final String title;
  final String buttonText;

  final String? id;
  final bool isEdit;

  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final TextEditingController imageKeyController;

  final String selectedCategory;
  final bool showInHome;

  const ProductFormDialog({
    super.key,
    required this.title,
    required this.buttonText,
    required this.nameController,
    required this.priceController,
    required this.descriptionController,
    required this.imageKeyController,
    required this.selectedCategory,
    required this.showInHome,
    this.id,
    this.isEdit = false,
  });

  @override
  State<ProductFormDialog> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends State<ProductFormDialog> {
  final List<String> categories = [
    "Serum",
    "Cream",
    "Cleanser",
    "Toner",
  ];

  late String selectedCategory;
  late bool showInHome;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory;
    showInHome = widget.showInHome;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),

      content: SingleChildScrollView(
        child: Column(
          children: [

            TextField(
              controller: widget.nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),

            TextField(
              controller: widget.priceController,
              decoration: const InputDecoration(labelText: "Price"),
              keyboardType: TextInputType.number,
            ),

            TextField(
              controller: widget.descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (v) {
                setState(() => selectedCategory = v!);
              },
            ),

            TextField(
              controller: widget.imageKeyController,
              decoration: const InputDecoration(labelText: "Image Key"),
            ),

            CheckboxListTile(
              value: showInHome,
              title: const Text("Show In Home"),
              onChanged: (v) {
                setState(() => showInHome = v ?? false);
              },
            ),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),

        ElevatedButton(
          onPressed: () async {
            final data = {
              'name': widget.nameController.text.trim(),
              'price': double.tryParse(widget.priceController.text) ?? 0,
              'description': widget.descriptionController.text.trim(),
              'category': selectedCategory,
              'imageKey': widget.imageKeyController.text.trim(),
              'showInHome': showInHome,
            };

            if (widget.isEdit) {
              await ProductService.update(widget.id!, data);
            } else {
              await ProductService.add(data);
            }

            Navigator.pop(context);
          },
          child: Text(widget.buttonText),
        ),
      ],
    );
  }
}