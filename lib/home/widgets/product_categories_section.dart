// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ProductCategoriesSection extends StatelessWidget {
//   const ProductCategoriesSection({super.key});

//   static const gold = Color(0xFFC6A77D);

//   final List<_Category> items = const [
//     _Category(
//       title: "Serums",
//       image: "assets/images/s1.jpg",
//     ),
//     _Category(
//       title: "Creams",
//       image: "assets/images/cr1.jpg",
//     ),
//     _Category(
//       title: "Cleansers",
//       image: "assets/images/cl7.jpg",
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 20, bottom: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [

//           /// ✨ TITLE SECTION
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               "Our Rituals",
//               style: GoogleFonts.playfairDisplay(
//                 fontSize: 26,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//           ),

//           const SizedBox(height: 6),

//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               "Discover your skincare essentials",
//               style: GoogleFonts.inter(
//                 fontSize: 12,
//                 color: Colors.black54,
//                 letterSpacing: 1.2,
//               ),
//             ),
//           ),

//           const SizedBox(height: 18),

//           /// 🧴 HORIZONTAL LIST
//           SizedBox(
//             height: 150,
//             child: ListView.separated(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               scrollDirection: Axis.horizontal,
//               itemCount: items.length,
//               separatorBuilder: (_, __) => const SizedBox(width: 14),
//               itemBuilder: (context, i) {
//                 final item = items[i];

//                 return _CategoryCard(item: item);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _CategoryCard extends StatelessWidget {
//   final _Category item;

//   const _CategoryCard({required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(40), // 🔥 oval shape
//       child: Stack(
//         children: [

//           /// IMAGE
//           Container(
//             width: 170,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(item.image),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),

//           /// DARK GRADIENT (luxury feel)
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//                 colors: [
//                   Colors.black.withOpacity(0.65),
//                   Colors.transparent,
//                 ],
//               ),
//             ),
//           ),

//           /// GLASS BORDER EFFECT
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.white.withOpacity(0.15),
//                 width: 1,
//               ),
//               borderRadius: BorderRadius.circular(40),
//             ),
//           ),

//           /// TEXT
//           Positioned(
//             bottom: 16,
//             left: 14,
//             right: 14,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [

//                 Text(
//                   item.title,
//                   style: GoogleFonts.playfairDisplay(
//                     fontSize: 18,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),

//                 const SizedBox(height: 4),

//                 Container(
//                   width: 40,
//                   height: 2,
//                   decoration: BoxDecoration(
//                     color: ProductCategoriesSection.gold,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _Category {
//   final String title;
//   final String image;

//   const _Category({
//     required this.title,
//     required this.image,
//   });
// }