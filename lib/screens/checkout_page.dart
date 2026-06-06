import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../checkout/payment_card.dart';
import '../checkout/app_snackbar.dart';

import '../screens/card_payment_page.dart';
import '../screens/paypal_payment_page.dart';
import '../screens/cash_on_delivery_page.dart';

import '../utils/app_colors.dart';
import '../Component/app_button.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? selectedPayment;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("You must login first")),
      );
    }

    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('cart');

    return Scaffold(
      backgroundColor: const Color(0xFFF7F3EE),

      /// ================= APP BAR (UNIFIED COLOR)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.gold),
        title: Text(
          "SECURE CHECKOUT",
          style: TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: cartRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text("Your cart is empty"));
          }

          double total = 0;
          for (var d in docs) {
            final data = d.data() as Map<String, dynamic>;
            total += (data['price'] ?? 0) * (data['qty'] ?? 1);
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                /// ================= TOTAL CARD (slightly cleaned)
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total"),
                      Text(
                        "\$${total.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.gold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                PaymentCard(
                  title: "Credit / Debit Card",
                  icon: Icons.credit_card,
                  selected: selectedPayment == "card",
                  color: AppColors.gold,
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CardPaymentPage(onSuccess: () {}),
                      ),
                    );

                    if (result == true) {
                      setState(() => selectedPayment = "card");
                    }
                  },
                ),

                PaymentCard(
                  title: "PayPal",
                  icon: Icons.account_balance_wallet,
                  selected: selectedPayment == "paypal",
                  color: AppColors.gold,
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaypalPaymentPage(onSuccess: () {}),
                      ),
                    );

                    if (result == true) {
                      setState(() => selectedPayment = "paypal");
                    }
                  },
                ),

                PaymentCard(
                  title: "Cash on Delivery",
                  icon: Icons.local_shipping,
                  selected: selectedPayment == "cash",
                  color: AppColors.gold,
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CashOnDeliveryPage(onSuccess: () {}),
                      ),
                    );

                    if (result == true) {
                      setState(() => selectedPayment = "cash");
                    }
                  },
                ),

                const Spacer(),

                /// ================= CONFIRM BUTTON (UNIFIED)
                AppButton(
                  text: "CONFIRM ORDER",
                  backgroundColor: AppColors.gold,
                  onPressed: () async {

                    if (selectedPayment == null) {
                      AppSnackBar.show(
                        context,
                        "Please select payment method",
                      );
                      return;
                    }

                    await FirebaseFirestore.instance
                        .collection('orders')
                        .add({
                      "userId": user.uid,
                      "items": docs.map((e) => e.data()).toList(),
                      "total": total,
                      "paymentMethod": selectedPayment,
                      "createdAt": DateTime.now(),
                    });

                    for (var d in docs) {
                      await d.reference.delete();
                    }

                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Order placed successfully"),
                      ),
                    );

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}