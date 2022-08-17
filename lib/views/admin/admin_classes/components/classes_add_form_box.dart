part of admin_classes_view;

class ClassesAddFormBox extends GetView<AdminClassesController> {
  const ClassesAddFormBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: secondaryColor,
            border: Border.all(color: Colors.white10),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Obx(
          () {
            if (controller.editingClasses.value != null) {
              controller.classNameFocusNode.requestFocus();
              controller.tfAddFormController.text =
                  controller.editingClasses.value!.className!;
            } else {
              controller.tfAddFormController.text = "";
            }

            return Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: SizedBox(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  direction: Axis.horizontal,
                  children: [
                    _title(),
                    const ClassesCategorySelectBox(),
                    _classNameInput(),
                    _actionButtons(),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget _actionButtons() {
    return Row(
      children: [
        // Cancel Button
        if (controller.editingClasses.value != null)
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: warningColor,
              ),
              onPressed: () {
                controller.editingClasses.value = null;
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.cancel,
                    color: secondaryColor,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "İptal",
                        style: TextStyle(
                            color: secondaryColor, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (controller.editingClasses.value != null)
          const SizedBox(
            width: defaultPadding / 2,
          ),
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: controller.editingClasses.value == null
                    ? Colors.amber
                    : infoColor,
              ),
              onPressed: () {
                if (controller.editingClasses.value == null) {
                  _saveClass();
                } else {
                  _editClasses(controller.editingClasses.value);
                }
              },
              child: Row(
                children: [
                  if (controller.statusAddingClass.value)
                    const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: secondaryColor,
                        )),
                  if (!controller.statusAddingClass.value)
                    const SizedBox(
                        child: Icon(
                      Icons.save,
                      color: secondaryColor,
                    )),
                  Expanded(
                    child: Center(
                      child: Text(
                        controller.editingClasses.value == null
                            ? "Kaydet"
                            : "Güncelle",
                        style: const TextStyle(
                            color: secondaryColor, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget _classNameInput() {
    return SizedBox(
      height: 45,
      child: TextFormField(
        onFieldSubmitted: (value) {
          _saveClass();
        },
        focusNode: controller.classNameFocusNode,
        textInputAction: TextInputAction.go,
        controller: controller.tfAddFormController,
        style: TextStyle(
            color: controller.editingClasses.value == null
                ? Colors.amber
                : infoColor),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: controller.editingClasses.value == null
              ? "Sınıf Adı"
              : controller.editingClasses.value?.className,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Text(
        controller.editingClasses.value == null
            ? "Sınıf Ekle"
            : "Sınıf Güncelle",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: controller.editingClasses.value == null
              ? Colors.amber
              : infoColor,
        ),
      ),
    );
  }

  void _saveClass() {
    if (controller.tfAddFormController.text.trim().isEmpty) {
    } else {
      final Classes classes = Classes(
          schoolID: "w7WZvgcVPKVheXnhxMHE",
          className: controller.tfAddFormController.text,
          classLevel: controller.selectedClassesCategory.value);
      controller.addClass(classes);

      Get.snackbar(
        "Başarılı",
        "Sınıf başarıyla eklendi",
        duration: const Duration(seconds: 2),
        colorText: secondaryColor,
        backgroundColor: infoColor,
      );
    }
  }

  void _editClasses(Classes? classes) {
    if (classes != null) {
      if (controller.tfAddFormController.text.trim().isEmpty) {
        debugPrint("Boşşş");
      } else {
        classes.className = controller.tfAddFormController.text;
        classes.classLevel = controller.selectedClassesCategory.value;
        controller.updateClasses(classes);
        Get.snackbar(
          "Başarılı",
          "Sınıf adı başarıyla güncellendi",
          duration: const Duration(seconds: 2),
          colorText: secondaryColor,
          backgroundColor: infoColor,
        );
      }
    }
  }
}
