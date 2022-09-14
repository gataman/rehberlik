library admin_trial_exam_result_view;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/custom_dialog.dart';
import 'package:rehberlik/common/widgets/button_with_icon.dart';
import 'package:rehberlik/models/trial_exam.dart';
import 'package:rehberlik/views/admin/admin_base/admin_base_views.dart';
import 'package:rehberlik/views/admin/admin_student_detail/admin_student_detail_imports.dart';
import 'package:rehberlik/views/admin/admin_trial_exam_detail/components/states/trial_exam_result_default_view.dart';
import 'package:rehberlik/views/admin/admin_trial_exam_detail/cubit/trial_exam_result_cubit.dart';
import 'package:syncfusion_flutter_core/localizations.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../core/widgets/containers/app_list_box_container.dart';
import '../../../core/widgets/text/app_box_title.dart';
import '../../../models/helpers/trial_exam_average.dart';
import '../admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import 'admin_trial_exam_result_imports.dart';
import 'components/states/trial_exam_result_statics_view.dart';

part 'components/states/trial_exam_result_data_grid.dart';

part 'components/trial_exam_result_menu.dart';

part 'components/trial_exam_result_container_view.dart';

part 'components/states/trial_exam_result_uploaded_view.dart';

class AdminTrialExamResultView extends AdminBaseViews {
  final TrialExam trialExam;

  const AdminTrialExamResultView({required this.trialExam, Key? key}) : super(key: key);

  @override
  Widget get firstView => TrialExamResultContainerView();

  @override
  Widget get secondView => const TrialExamResultUploads();

  @override
  bool get isBack => true;

  @override
  bool get isFullPage => true;

  @override
  List<BlocProvider<StateStreamableSource<Object?>>> get providers {
    final providers = <BlocProvider>[
      BlocProvider<TrialExamResultCubit>(
        create: (_) => TrialExamResultCubit()..fetchTrialExamResult(exam: trialExam),
        lazy: false,
      ),
    ];
    return providers;
  }
}
