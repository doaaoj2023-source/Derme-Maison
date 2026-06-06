import 'package:flutter/material.dart';

class ProductImageSection extends StatelessWidget {

  final String image;
  final double imageScale;

  const ProductImageSection({
    super.key,
    required this.image,
    required this.imageScale,
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.topCenter,

      child: Container(

        width: double.infinity,

        // ✅ ارتفاع الصورة
        height: size.height * 0.70,

        child: Transform.scale(

          scale: imageScale,

          child: Image.asset(

            image,

            alignment: Alignment.topCenter,

            fit: BoxFit.cover,

            // ✅ يمنع توقف التطبيق لو الصورة مش موجودة
            errorBuilder:
                (context, error, stackTrace) {

              return Container(

                color: Colors.grey.shade200,

                child: const Center(

                  child: Icon(
                    Icons.image_not_supported,
                    size: 70,
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}