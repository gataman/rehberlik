library admin_subjects_view;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/helpers/lesson_with_subject.dart';
import '../admin_base/admin_base_view.dart';
import 'components/subject_form_box/cubit/edit_subject_cubit.dart';
import 'components/subject_form_box/subject_form_box.dart';
import 'components/subject_list_card/cubit/subject_list_cubit.dart';
import 'components/subject_list_card/subject_list_card.dart';

class AdminSubjectsView extends AdminBaseView {
  const AdminSubjectsView({required this.lessonWithSubject, Key? key}) : super(key: key);

  //@PathParam('lessonName') required this.lessonName,

  final LessonWithSubject lessonWithSubject;

  //final String lessonName;

  @override
  Widget get firstView => SubjectListCard(
        lessonName: lessonWithSubject.lesson.lessonName ?? '',
      );

  @override
  Widget get secondView => SubjectAddFormBox(
        lessonID: lessonWithSubject.lesson.id!,
      );

  @override
  bool get isBack => true;

  @override
  List<BlocProvider<StateStreamableSource<Object?>>> get providers {
    final providers = <BlocProvider>[
      BlocProvider<SubjectListCubit>(
          create: (_) => SubjectListCubit()..setSubjectList(list: lessonWithSubject.subjectList)),
      BlocProvider<EditSubjectCubit>(create: (_) => EditSubjectCubit()),
    ];
    return providers;
  }
}
