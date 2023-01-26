import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../common/constants.dart';
import '../../../../common/enums/user_type.dart';
import '../../../../common/helper/excel_creator/student_detail_excel_builder/student_detail_excel_builder.dart';
import '../../../../common/navigaton/app_router/app_router.dart';
import '../../../../common/navigaton/app_router/app_routes.dart';
import '../../../../common/widgets/button_with_icon.dart';
import '../../../../common/widgets/loading_button.dart';
import '../../../../core/init/locale_manager.dart';
import '../../../../core/init/pref_keys.dart';
import '../../../../core/widgets/text/app_box_title.dart';
import '../../../../models/student.dart';

class StudentInfoCard extends StatefulWidget {
  final Student? student;

  const StudentInfoCard({Key? key, this.student}) : super(key: key);

  @override
  State<StudentInfoCard> createState() => _StudentInfoCardState();
}

class _StudentInfoCardState extends State<StudentInfoCard> {
  bool showPassword = false;
  int? userType;

  @override
  void initState() {
    userType = SharedPrefs.instance.getInt(PrefKeys.userType.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var excelBuilder = StudentDetailExcelBuilder(context);
    if (widget.student != null) {
      return Column(
        children: [
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Text(
                    widget.student!.studentName.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(defaultPadding / 3),
                        child:
                            SizedBox(height: 80, width: 80, child: _setStudentProfileImage(widget.student!.photoUrl)),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding / 2),
                  child: Table(
                    defaultColumnWidth: const IntrinsicColumnWidth(),
                    children: [
                      //buildRow(label: "T.C. Kimlik No", value: "", context: context),
                      buildRow(label: "Sınıfı", value: widget.student!.className ?? '', context: context),
                      buildRow(label: "Numarası", value: widget.student!.studentNumber ?? '', context: context),
                      buildRow(label: "Baba Adı", value: widget.student!.fatherName ?? '', context: context),
                      buildRow(
                        label: "Anne Adı",
                        value: widget.student!.motherName ?? '',
                        context: context,
                      ),
                      if (userType != UserType.student.type)
                        buildPasswordRow(
                          context: context,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: AppBoxTitle(
                    title: 'İşlemler',
                    isBack: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: ButtonWithIcon(
                    labelText: 'Öğrenci Başarı Karnesi',
                    icon: Icons.line_axis_rounded,
                    onPressed: () {
                      if (userType == UserType.student.type) {
                        context.router.pushNamed(AppRoutes.routeStudentTrialExam);
                      } else {
                        context.router.push(
                          AdminStudentsTrialExamDetailRoute(student: widget.student),
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: LoadingButton(
                      text: 'Çalışma Programı İndir',
                      iconData: Icons.download,
                      loadingListener: excelBuilder.notifier,
                      onPressed: () {
                        excelBuilder.notifier.value = true;
                        excelBuilder.build(widget.student!);
                      }),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  TableRow buildRow({required String label, required String value, required BuildContext context}) {
    return TableRow(
      children: [
        SizedBox(
          height: 30,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        Text(
          ":",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  TableRow buildPasswordRow({required BuildContext context}) {
    return TableRow(
      children: [
        SizedBox(
          height: 30,
          child: InkWell(
            mouseCursor: SystemMouseCursors.click,
            onTap: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            child: Text(
              showPassword ? 'Şifreyi Gizle' : 'Şifreyi Göster',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
        Text(
          ":",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SelectableText(
          showPassword ? widget.student?.password ?? '' : '******',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _setStudentProfileImage(String? photoUrl) {
    return photoUrl != null
        ? CircleAvatar(
            backgroundImage: NetworkImage(photoUrl),
          )
        : const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person),
          );
  }
}


/*
ElevatedButton.icon(
                    onPressed: () {
                      context.router.push(AdminStudentsTrialExamDetailRoute(student: student));
                    },
                    icon: Icon(
                      Icons.line_axis,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    label: Text(
                      'Deneme İstatistikleri',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
*/