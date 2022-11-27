library admin_trial_exam_view;

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/custom_dialog.dart';
import 'package:rehberlik/common/widgets/classes_level_select_box.dart';
import 'package:rehberlik/common/widgets/default_circular_progress.dart';
import 'package:rehberlik/common/widgets/loading_button.dart';
import 'package:rehberlik/core/init/extentions.dart';
import 'package:rehberlik/core/init/locale_keys.g.dart';
import 'package:rehberlik/core/widgets/buttons/app_cancel_form_button.dart';
import 'package:rehberlik/core/widgets/list_tiles/app_liste_tile.dart';
import 'package:rehberlik/core/widgets/text/app_box_title.dart';
import 'package:rehberlik/core/widgets/text/app_empty_warning_text.dart';
import 'package:rehberlik/core/widgets/text/app_menu_title.dart';
import 'package:rehberlik/core/widgets/text_form_fields/app_outline_text_form_field.dart';
import 'package:rehberlik/models/trial_exam.dart';
import 'package:rehberlik/views/admin/admin_base/admin_base_view.dart';
import 'package:rehberlik/views/admin/admin_trial_exam/components/trial_exam_form_box/cubit/trial_exam_form_box_cubit.dart';
import 'package:rehberlik/views/admin/admin_trial_exam/components/trial_exam_list_card/cubit/trial_exam_list_cubit.dart';
import 'package:flutter/material.dart';

import '../../../common/navigaton/app_router/app_router.dart';
import '../../../common/widgets/trial_exam_type_select_box.dart';
import '../../../core/widgets/containers/app_form_box_elements.dart';

part 'components/trial_exam_list_card/trial_exam_list_card.dart';
part 'components/trial_exam_form_box/trial_exam_form_box.dart';

class AdminTrialExamView extends AdminBaseView {
  const AdminTrialExamView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const TrialExamListCard();

  @override
  Widget get secondView => const TrialExamAddFormBox();

  @override
  List<BlocProvider<StateStreamableSource<Object?>>> get providers {

    final providers = <BlocProvider>[
      BlocProvider<TrialExamListCubit>(create: (_) => TrialExamListCubit()..fetchTrialExamList()),
      BlocProvider<TrialExamFormBoxCubit>(create: (_) => TrialExamFormBoxCubit()),
    ];
    return providers;
  }
}
