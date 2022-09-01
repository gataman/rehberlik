library admin_lessons_view;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/custom_dialog.dart';
import 'package:rehberlik/common/navigaton/admin_routes.dart';
import 'package:rehberlik/common/widgets/classes_level_select_box.dart';
import 'package:rehberlik/core/widgets/buttons/app_cancel_form_button.dart';
import 'package:rehberlik/common/widgets/default_circular_progress.dart';
import 'package:rehberlik/common/widgets/loading_button.dart';
import 'package:rehberlik/common/widgets/locale_text.dart';
import 'package:rehberlik/core/init/extentions.dart';
import 'package:rehberlik/core/init/locale_keys.g.dart';
import 'package:rehberlik/core/widgets/list_tiles/app_liste_tile.dart';
import 'package:rehberlik/core/widgets/text/app_box_title.dart';
import 'package:rehberlik/core/widgets/text/app_empty_warning_text.dart';
import 'package:rehberlik/core/widgets/text_form_fields/app_outline_text_form_field.dart';
import 'package:rehberlik/models/lesson.dart';
import 'package:rehberlik/views/admin/admin_base/admin_base_views.dart';
import 'package:rehberlik/views/admin/admin_lessons/components/lesson_form_box/cubit/lesson_form_box_cubit.dart';
import 'package:rehberlik/views/admin/admin_lessons/components/lesson_list_card/cubit/lesson_list_cubit.dart';

part 'components/lesson_list_card/lesson_list_card.dart';
part 'components/lesson_form_box/lesson_form_box.dart';

class AdminLessonsView extends AdminBaseViews {
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
