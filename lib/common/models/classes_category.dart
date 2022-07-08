class ClassesCategory {
  int classIndex;
  String className;
  int classLevel;

  ClassesCategory(
      {required this.classIndex,
      required this.className,
      required this.classLevel});
}

final List<ClassesCategory> classesCategoryList = <ClassesCategory>[
  ClassesCategory(classIndex: 0, className: "5.Sınıflar", classLevel: 5),
  ClassesCategory(classIndex: 1, className: "6.Sınıflar", classLevel: 6),
  ClassesCategory(classIndex: 2, className: "7.Sınıflar", classLevel: 7),
  ClassesCategory(classIndex: 3, className: "8.Sınıflar", classLevel: 8),
];
