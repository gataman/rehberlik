library admin_subjects_view;

import 'admin_subjects_imports.dart';

part 'components/subject_list_box.dart';
part 'components/subject_add_form_box.dart';

class AdminSubjectsView extends AdminBaseView<AdminSubjectsController> {
  final String lessonID;
  final String lessonName;

  const AdminSubjectsView(
      {Key? key, required this.lessonID, required this.lessonName})
      : super(key: key);

  @override
  Widget get firstView => SubjectListBox(
        lessonID: lessonID,
        lessonName: lessonName,
      );

  @override
  Widget get secondView => SubjectAddFormBox(
        lessonID: lessonID,
      );
}
