import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/models/teacher.dart';
import 'package:rehberlik/views/admin/admin_base/admin_base_view.dart';
import 'package:rehberlik/views/admin/admin_classes/components/class_form_box/cubit/class_form_box_cubit.dart';

import '../../admin/admin_classes/components/class_form_box/class_form_box.dart';
import '../../admin/admin_classes/components/class_list_card/class_list_card.dart';

class TeacherClassesView extends AdminBaseView {
  const TeacherClassesView({Key? key}) : super(key: key);

  @override
  Widget get firstView => getData();

  @override
  Widget get secondView => const ClassFormBox();

  @override
  bool get isFullPage => teacherType == TeacherType.teacher;

  @override
  List<BlocProvider<StateStreamableSource<Object?>>> get providers {
    final providers = <BlocProvider>[
      BlocProvider<ClassFormBoxCubit>(create: (_) => ClassFormBoxCubit()),
    ];
    return providers;
  }

  Widget getData() {
    return const ClassListCard();
  }
}
