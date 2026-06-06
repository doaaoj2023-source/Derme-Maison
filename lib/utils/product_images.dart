class ProductImages {
  static const Map<String, String> map = {
    //  SERUMS
    "s1": "images/s1.jpg",
    "s2": "images/s2.jpg",
    "s3": "images/s3.jpeg",
    "s4": "images/s4.jpeg",
    "s5": "images/s5.jpg",
    "s6": "images/s6.jpg",
    "s7": "images/s7.jpg",

    //  CREAMS
    "cr1": "images/cr1.jpg",
    "cr2": "images/cr2.jpeg",
    "cr3": "images/cr3.jpg",
    "cr4": "images/cr4.jpg",
    "cr5": "images/cr5.jpg",
    "cr6": "images/cr6.jpg",
    "cr7": "images/cr7.jpg",
    "cr8": "images/cr8.jpg",

    //  CLEANSERS
    "cl1": "images/cl1.jpeg",
    "cl2": "images/cl2.jpg",
    "cl3": "images/cl3.jpg",
    "cl4": "images/cl4.jpeg",
    "cl5": "images/cl5.jpg",
    "cl6": "images/cl6.jpg",
    "cl7": "images/cl7.jpg",

    //  TONERS
    "t1": "images/t1.jpg",
    "t2": "images/t2.jpg",
    "t3": "images/t3.jpg",
    "t4": "images/t4.jpg",
  };

  static String getImage(String key) {
    final img = map[key.toLowerCase().trim()];

    if (img == null || img.isEmpty) {
      return "images/default.jpg";
    }

    return img;
  }
}