library admin_classes_view;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/custom_dialog.dart';
import 'package:rehberlik/common/widgets/classes_level_select_box.dart';
import 'package:rehberlik/common/widgets/default_circular_progress.dart';
import 'package:rehberlik/common/widgets/loading_button.dart';
import 'package:rehberlik/core/init/extentions.dart';
import 'package:rehberlik/core/init/locale_keys.g.dart';
import 'package:rehberlik/core/init/pref_keys.dart';
import 'package:rehberlik/core/widgets/buttons/app_cancel_form_button.dart';
import 'package:rehberlik/core/widgets/containers/app_list_box_container.dart';
import 'package:rehberlik/core/widgets/list_tiles/app_liste_tile.dart';
import 'package:rehberlik/core/widgets/text/app_box_title.dart';
import 'package:rehberlik/core/widgets/text/app_empty_warning_text.dart';
import 'package:rehberlik/core/widgets/text_form_fields/app_outline_text_form_field.dart';
import 'package:rehberlik/models/classes.dart';
import 'package:rehberlik/models/student_with_class.dart';
import 'package:rehberlik/views/admin/admin_base/admin_base_views.dart';
import 'package:rehberlik/views/admin/admin_classes/components/class_form_box/cubit/class_form_box_cubit.dart';
import 'package:rehberlik/views/admin/admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import 'package:rehberlik/views/admin/admin_students/components/student_list_card/cubit/student_list_cubit.dart';

import '../../../common/navigaton/admin_routes.dart';
import '../../../core/init/locale_manager.dart';

part 'components/class_form_box/class_form_box.dart';
part 'components/class_list_card/class_list_card.dart';

class AdminClassesView extends AdminBaseViews {
  const AdminClassesView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const ClassListCard();

  @override
  Widget get secondView => const ClassFormBox();

  @override
  List<BlocProvider<StateStreamableSource<Object?>>> get providers {
    final providers = <BlocProvider>[
      BlocProvider<ClassFormBoxCubit>(create: (_) => ClassFormBoxCubit()),
    ];
    return providers;
  }
}
