import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../Component/app_button.dart';

class CashOnDeliveryPage extends StatefulWidget {
  final VoidCallback onSuccess;

  const CashOnDeliveryPage({
    super.key,
    required this.onSuccess,
  });

  @override
  State<CashOnDeliveryPage> createState() => _CashOnDeliveryPageState();
}

class _CashOnDeliveryPageState extends State<CashOnDeliveryPage> {
  final address = TextEditingController();
  final phone = TextEditingController();

  @override
  void dispose() {
    address.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3EE),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        ///  unified back button color
        iconTheme: IconThemeData(color: AppColors.gold),

        ///  unified title style
        title: Text(
          "CASH ON DELIVERY",
          style: TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            ///  unified title color
            Text(
              "Enter delivery details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.gold,
              ),
            ),

            const SizedBox(height: 20),

            _field(address, "Address"),
            const SizedBox(height: 10),
            _field(phone, "Phone number"),

            const Spacer(),

            ///  unified button
            AppButton(
              text: "CONFIRM ORDER",
              backgroundColor: AppColors.gold,
              onPressed: () {
                if (address.text.trim().isEmpty ||
                    phone.text.trim().isEmpty) {
                  return;
                }

                widget.onSuccess();
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ),
    );
  }

  ///  reusable input
  Widget _field(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}