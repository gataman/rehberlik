class ValidatorHelper {
  static String? emptyValidator({String? value, required String message}) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  static String? emptyNumericValidator({String? value, required String message}) {
    if (value == null || value.isEmpty) {
      return message;
    }

    final numericValue = int.tryParse(value);
    if (numericValue == null) {
      return 'Sayısal bir veri girilmelidir';
    }

    return null;
  }
}
