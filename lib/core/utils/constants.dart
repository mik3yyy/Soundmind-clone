class Constants {
  static List<String> genders = ["male", "female", "others"];
  static int convertGender(String gender) {
    switch (gender) {
      case 'male':
        return 1;
      case 'female':
        return 2;
      case 'others':
        return 3;
      default:
        return 1;
    }
  }

  static String Naira = '₦';
}
