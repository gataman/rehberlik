import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/responsive.dart';
import 'package:rehberlik/views/admin/admin_classes/components/classes_add_form_box.dart';
import 'package:rehberlik/views/admin/admin_classes/components/classes_list_box.dart';

class AdminClassesView extends StatefulWidget {
  const AdminClassesView({Key? key}) : super(key: key);

  @override
  State<AdminClassesView> createState() => _AdminClassesViewState();
}

class _AdminClassesViewState extends State<AdminClassesView> {
  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? _mobileContent(context)
        : _desktopContent(context);
  }

  Widget _desktopContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Expanded(flex: 3, child: ClassesListBox()),
        SizedBox(
          width: defaultPadding,
        ),
        Expanded(flex: 2, child: ClassesAddFormBox())
      ],
    );
  }

  Widget _mobileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        ClassesAddFormBox(),
        SizedBox(
          height: defaultPadding,
        ),
        ClassesListBox()
      ],
    );
  }

  void _showDialog() {
    Get.defaultDialog(
        actions: <Widget>[
          TextButton(
            child: const Text(
              "Kapat",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Get.back();
            },
          )
        ],
        backgroundColor: infoColor,
        title: "",
        titlePadding: EdgeInsets.zero,
        content: SizedBox(height: 200, child: ClassesAddFormBox()),
        contentPadding: EdgeInsets.zero);
  }
}
