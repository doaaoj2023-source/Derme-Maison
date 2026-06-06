class PaymentFormatter {
  static String formatCard(String input) {
    final cleaned = input.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < cleaned.length; i++) {
      if (i % 4 == 0 && i != 0) buffer.write(' ');
      buffer.write(cleaned[i]);
    }

    return buffer.toString();
  }
}