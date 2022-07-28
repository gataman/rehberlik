import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/views/admin/dashboard/admin_dashboard_controller.dart';

class MeetingTypeSelectBox extends StatelessWidget {
  final _controller = Get.put(AdminDashboardController());

  MeetingTypeSelectBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonFormField<String>(
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
        value: meetingTypeList[_controller.meetingTypeIndex.value],
        icon: const Icon(Icons.keyboard_arrow_down),
        onChanged: (String? newValue) {
          if (newValue != null) {
            _controller.meetingTypeIndex.value =
                meetingTypeList.indexOf(newValue);
          }
        },
        items: meetingTypeList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          );
        }).toList(),
      );
    });
  }
}
