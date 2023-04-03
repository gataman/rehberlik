library admin_lessons_view;

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../common/constants.dart';
import '../../../common/custom_dialog.dart';
import '../../../common/widgets/classes_level_select_box.dart';
import '../../../core/init/locale_manager.dart';
import '../../../core/init/pref_keys.dart';
import 'package:rehberlik/core/widgets/buttons/app_cancel_form_button.dart';
import 'package:rehberlik/common/widgets/default_circular_progress.dart';
import 'package:rehberlik/common/widgets/loading_button.dart';
import 'package:rehberlik/core/init/extensions.dart';
import 'package:rehberlik/core/init/locale_keys.g.dart';
import 'package:rehberlik/core/widgets/containers/app_form_box_elements.dart';
import 'package:rehberlik/core/widgets/list_tiles/app_liste_tile.dart';
import 'package:rehberlik/core/widgets/text/app_box_title.dart';
import 'package:rehberlik/core/widgets/text/app_empty_warning_text.dart';
import 'package:rehberlik/core/widgets/text/app_menu_title.dart';
import 'package:rehberlik/core/widgets/text_form_fields/app_outline_text_form_field.dart';
import 'package:rehberlik/models/helpers/lesson_with_subject.dart';
import 'package:rehberlik/models/lesson.dart';
import 'package:rehberlik/views/admin/admin_base/admin_base_view.dart';
import 'package:rehberlik/views/admin/admin_lessons/components/lesson_form_box/cubit/lesson_form_box_cubit.dart';
import 'package:rehberlik/views/admin/admin_lessons/components/lesson_list_card/cubit/lesson_list_cubit.dart';

import '../../../common/navigaton/app_router/app_router.dart';

part 'components/lesson_list_card/lesson_list_card.dart';
part 'components/lesson_form_box/lesson_form_box.dart';

class AdminLessonsView extends AdminBaseView {
  const AdminLessonsView({Key? key}) : super(key: key);

  @override
  Widget get firstView => LessonListCard();

  @override
  Widget get secondView => const LessonFormBox();

  @override
  List<BlocProvider<StateStreamableSource<Object?>>> get providers {
    final providers = <BlocProvider>[
      BlocProvider<LessonFormBoxCubit>(create: (_) => LessonFormBoxCubit()),
    ];
    return providers;
  }
}
