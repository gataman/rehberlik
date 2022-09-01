library admin_students_view;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/widgets/default_circular_progress.dart';
import 'package:rehberlik/core/init/extentions.dart';
import 'package:rehberlik/core/init/locale_keys.g.dart';
import 'package:rehberlik/core/widgets/buttons/app_small_rounded_button.dart';
import 'package:rehberlik/core/widgets/containers/app_list_box_container.dart';
import 'package:rehberlik/core/widgets/text/app_box_title.dart';
import 'package:rehberlik/core/widgets/text/app_empty_warning_text.dart';
import 'package:rehberlik/models/student.dart';
import 'package:rehberlik/models/student_with_class.dart';
import 'package:rehberlik/views/admin/admin_base/admin_base_views.dart';
import 'package:rehberlik/views/admin/admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import 'package:rehberlik/views/admin/admin_students/components/student_list_card/cubit/student_list_cubit.dart';

part 'components/student_list_card/student_list_card.dart';
part 'components/student_form_box/student_form_box.dart';

class AdminStudentsView extends AdminBaseViews {
  const AdminStudentsView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const StudentListBox();

  @override
  Widget get secondView => const StudentFormBox();
}
