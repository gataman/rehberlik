library admin_subjects_view;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/custom_dialog.dart';
import 'package:rehberlik/core/init/extentions.dart';
import 'package:rehberlik/core/init/locale_keys.g.dart';
import 'package:rehberlik/core/widgets/buttons/app_cancel_form_button.dart';
import 'package:rehberlik/core/widgets/list_tiles/app_liste_tile.dart';
import 'package:rehberlik/core/widgets/text/app_box_title.dart';
import 'package:rehberlik/core/widgets/text/app_empty_warning_text.dart';
import 'package:rehberlik/core/widgets/text/app_menu_title.dart';
import 'package:rehberlik/core/widgets/text_form_fields/app_outline_text_form_field.dart';
import 'package:rehberlik/models/helpers/lesson_with_subject.dart';
import 'package:rehberlik/models/lesson.dart';
import '../../../core/widgets/containers/app_form_box_elements.dart';
import '../../../core/widgets/containers/app_list_box_container.dart';
import 'admin_subjects_imports.dart';

part 'components/subject_list_card/subject_list_card.dart';

part 'components/subject_form_box/subject_form_box.dart';

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
