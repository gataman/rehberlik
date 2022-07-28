import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/models/classes.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_controller.dart';
import 'package:rehberlik/views/admin/admin_classes/components/classes_category_select_box.dart';

class ClassesAddFormBox extends StatefulWidget {
  const ClassesAddFormBox({Key? key}) : super(key: key);

  @override
  State<ClassesAddFormBox> createState() => _ClassesAddFormBoxState();
}

class _ClassesAddFormBoxState extends State<ClassesAddFormBox> {
  final _controller = Get.put(AdminClassesController());
  final _tfAddFormController = TextEditingController();
  int _selectedCategory = 5;
  late FocusNode _classNameFocusNode;
  Classes? _classes;

  @override
  void initState() {
    _classNameFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _tfAddFormController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: secondaryColor,
            border: Border.all(color: Colors.white10),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Obx(
          () {
            _classes = _controller.editingClasses.value;
            if (_classes != null) {
              _classNameFocusNode.requestFocus();
              _tfAddFormController.text = _classes!.className!;
            } else {
              _tfAddFormController.text = "";
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
                    ClassesCategorySelectBox(valueChanged: (classCategory) {
                      _selectedCategory = classCategory;
                    }),
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
        if (_classes != null)
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: warningColor,
              ),
              onPressed: () {
                _controller.editingClasses.value = null;
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
        if (_classes != null)
          const SizedBox(
            width: defaultPadding / 2,
          ),
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: _classes == null ? Colors.amber : infoColor,
              ),
              onPressed: () {
                if (_classes == null) {
                  _saveClass();
                } else {
                  _editClasses(_classes);
                }
              },
              child: Row(
                children: [
                  if (_controller.statusAddingClass.value)
                    const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: secondaryColor,
                        )),
                  if (!_controller.statusAddingClass.value)
                    const SizedBox(
                        child: Icon(
                      Icons.save,
                      color: secondaryColor,
                    )),
                  Expanded(
                    child: Center(
                      child: Text(
                        _classes == null ? "Kaydet" : "Güncelle",
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
        focusNode: _classNameFocusNode,
        textInputAction: TextInputAction.go,
        controller: _tfAddFormController,
        style: TextStyle(color: _classes == null ? Colors.amber : infoColor),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: _classes == null ? "Sınıf Adı" : _classes?.className,
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
        _classes == null ? "Sınıf Ekle" : "Sınıf Güncelle",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: _classes == null ? Colors.amber : infoColor,
        ),
      ),
    );
  }

  void _saveClass() {
    if (_tfAddFormController.text.trim().isEmpty) {
    } else {
      final Classes classes = Classes(
          schoolID: "w7WZvgcVPKVheXnhxMHE",
          className: _tfAddFormController.text,
          classLevel: _selectedCategory);
      _controller.addClass(classes);

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
      if (_tfAddFormController.text.trim().isEmpty) {
        debugPrint("Boşşş");
      } else {
        classes.className = _tfAddFormController.text;
        classes.classLevel = _selectedCategory;
        _controller.updateClasses(classes);
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
