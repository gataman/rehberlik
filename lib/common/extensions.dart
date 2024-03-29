//Group By
//final lastNameMap = listOfPeople.groupBy((person) => person.lastName);

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(<K, List<E>>{},
      (Map<K, List<E>> map, E element) => map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

extension FirstWhereNew<T> on List<T> {
  T? findOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension DecimalCount on double {
  double decimalCount(int count) {
    return double.parse(toStringAsFixed(count));
  }
}

extension CheckExamType on double {
  double checkExamType(int examType) {
    if (examType == 1) {
      return (this * 20) / 15;
    } else {
      return this;
    }
  }
}

extension ParseDouble on Map<String, dynamic>? {
  double parseDouble(String key, {double defaultValue = 0.0}) {
    if (this == null) return defaultValue;

    if (!this!.containsKey(key)) return defaultValue;

    var rawValue = this![key];
    if (rawValue == null) return defaultValue;

    if (rawValue is double) return rawValue;

    if (rawValue is int) {
      return rawValue.toDouble();
    }

    if (rawValue is String) {
      return double.tryParse(rawValue) ?? defaultValue;
    }

    return defaultValue;
  }
}
