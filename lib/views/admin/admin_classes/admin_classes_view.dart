library admin_classes_view;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/core/init/extentions.dart';
import 'package:rehberlik/core/init/locale_keys.g.dart';
import 'package:rehberlik/core/widgets/containers/app_list_box_container.dart';
import 'package:rehberlik/core/widgets/list_tiles/app_liste_tile.dart';
import 'package:rehberlik/core/widgets/text/app_box_title.dart';
import 'package:rehberlik/core/widgets/text/app_empty_warning_text.dart';
import 'package:rehberlik/views/admin/admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import 'package:rehberlik/views/admin/admin_students/components/student_list_card/cubit/student_list_cubit.dart';

import 'admin_classes_imports.dart';
import 'package:rehberlik/models/student_with_class.dart';

part 'components/class_list_card/class_list_card.dart';
part 'components/classes_add_form_box.dart';
part 'components/classes_category_select_box.dart';

class AdminClassesView extends AdminBaseView<AdminClassesController> {
  const AdminClassesView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const ClassListCard();

  @override
  Widget get secondView => const ClassesAddFormBox();
}
