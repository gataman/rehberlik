part of admin_classes_view;

class ClassesCategorySelectBox extends GetView<AdminClassesController> {
  const ClassesCategorySelectBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonFormField<ClassesCategory>(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: -5, horizontal: defaultPadding / 2),
          hintStyle: TextStyle(color: Colors.white30),
          fillColor: secondaryColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white10),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        value: getClassesCategory(controller.selectedClassesCategory.value),
        icon: const Icon(Icons.keyboard_arrow_down),
        onChanged: (ClassesCategory? newValue) {
          controller.selectedClassesCategory.value = newValue!.classLevel;
        },
        items: classesCategoryList
            .map<DropdownMenuItem<ClassesCategory>>((ClassesCategory value) {
          return DropdownMenuItem<ClassesCategory>(
            value: value,
            child: Text(
              value.className,
              style: const TextStyle(fontSize: 14),
            ),
          );
        }).toList(),
      );
    });
  }

  ClassesCategory? getClassesCategory(int classLevel) {
    return classesCategoryList
        .where((element) => element.classLevel == classLevel)
        .first;
  }
}
