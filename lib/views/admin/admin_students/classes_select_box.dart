part of admin_students_view;

class ClassesSelectBox extends GetView<AdminStudentsController> {
  const ClassesSelectBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final classesList = controller.classController.studentWithClassList.value;
      final selectedIndex = controller.classController.selectedIndex.value;

      return Container(
        decoration: defaultBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              if (classesList == null) const DefaultCircularProgress(),
              if (classesList != null)
                const Text(
                  "Sınıf Seçin",
                  style: defaultTitleStyle,
                ),
              if (classesList != null)
                DropdownButtonFormField<StudentWithClass>(
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
                  value: classesList[selectedIndex],
                  icon: const Icon(Icons.keyboard_arrow_down),
                  onChanged: (StudentWithClass? newValue) {
                    if (newValue != null) {
                      controller.classController.selectedIndex.value =
                          classesList.indexOf(newValue);
                      //valueChanged(newValue.classLevel);
                      //_selectedCategory = newValue.classLevel;
                    }
                  },
                  items: classesList.map<DropdownMenuItem<StudentWithClass>>(
                      (StudentWithClass value) {
                    return DropdownMenuItem<StudentWithClass>(
                      value: value,
                      child: Text(
                        value.classes.className!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                )
            ],
          ),
        ),
      );
    });
  }
}
