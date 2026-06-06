abstract class PaymentValidator {
  String? validate(String value);
}

class CardNumberValidator implements PaymentValidator {
  @override
  String? validate(String value) {
    final clean = value.replaceAll(" ", "");
    if (clean.length != 16) {
      return "Card number must be 16 digits";
    }
    return null;
  }
}

class CardHolderValidator implements PaymentValidator {
  @override
  String? validate(String value) {
    if (value.trim().isEmpty) {
      return "Card holder name is required";
    }
    return null;
  }
}

class ExpiryValidator implements PaymentValidator {
  @override
  String? validate(String value) {
    if (value.length != 5) {
      return "Expiry must be MM/YY";
    }
    return null;
  }
}

class CvvValidator implements PaymentValidator {
  @override
  String? validate(String value) {
    if (value.length != 3) {
      return "CVV must be 3 digits";
    }
    return null;
  }
}

class PaypalEmailValidator implements PaymentValidator {
  @override
  String? validate(String value) {
    if (value.trim().isEmpty) {
      return "PayPal email is required";
    }

    if (!value.contains("@")) {
      return "Invalid PayPal email";
    }

    return null;
  }
}