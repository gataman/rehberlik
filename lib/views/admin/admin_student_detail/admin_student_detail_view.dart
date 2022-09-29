library admin_student_detail_view;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/core/widgets/text/app_box_title.dart';

import '../admin_base/admin_base_view.dart';
import 'admin_student_detail_imports.dart';
import 'components/student_detail_tab_view/question_follow/cubit/question_follow_list_cubit.dart';
import 'components/student_detail_tab_view/student_detail_tab_view.dart';
import 'components/student_detail_tab_view/time_table/cubit/time_table_list_cubit.dart';

part 'components/student_info_card.dart';

class AdminStudentDetailView extends AdminBaseView {
  final Student student;

  const AdminStudentDetailView({required this.student, Key? key}) : super(key: key);

  @override
  Widget get firstView => StudentDetailTabView(
        student: student,
      );

  @override
  Widget get secondView {
    return StudentInfoCard(student: student);
  }

  @override
  bool get isBack => true;

  @override
  Object? get refreshRoute => student;

  @override
  List<BlocProvider<StateStreamableSource<Object?>>> get providers {
    final providers = <BlocProvider>[
      BlocProvider<TimeTableListCubit>(
        create: (_) => TimeTableListCubit()..fetchTimeTableList(student: student),
        lazy: false,
      ),
      BlocProvider<QuestionFollowListCubit>(
          create: (_) => QuestionFollowListCubit()..fetchQuestionFollowList(studentID: student.id!), lazy: false),
    ];
    return providers;
  }
}
