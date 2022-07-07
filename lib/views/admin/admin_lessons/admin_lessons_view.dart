import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/responsive.dart';
import 'package:rehberlik/views/admin/admin_lessons/components/lesson_add_form_box.dart';
import 'package:rehberlik/views/admin/admin_lessons/components/lesson_list_box.dart';

class AdminLessonsView extends StatelessWidget {
  const AdminLessonsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context) ? _mobileContent() : _desktopContent();
  }

  Widget _desktopContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: LessonListBox(),
        ),
        const SizedBox(
          width: defaultPadding,
        ),
        const Expanded(
          flex: 2,
          child: LessonAddFormBox(),
        ),
      ],
    );
  }

  Widget _mobileContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LessonAddFormBox(),
        const SizedBox(
          height: defaultPadding,
        ),
        LessonListBox(),
      ],
    );
  }
}
