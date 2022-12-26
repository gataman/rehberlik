import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/views/admin/admin_quizzes/components/quiz_form_box.dart';
import 'package:rehberlik/views/admin/admin_quizzes/components/quiz_list_card.dart';
import 'package:rehberlik/views/admin/admin_quizzes/cubit/quiz_list_cubit.dart';

import '../admin_base/admin_base_view.dart';

class AdminQuizzesView extends AdminBaseView {
  const AdminQuizzesView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const QuizListCard();

  @override
  Widget get secondView => const QuizFormBox();

  @override
  List<BlocProvider<StateStreamableSource<Object?>>> get providers {
    final providers = <BlocProvider>[
      BlocProvider<QuizListCubit>(create: (_) => QuizListCubit()..fetchTrialExamList()),
    ];
    return providers;
  }
}
