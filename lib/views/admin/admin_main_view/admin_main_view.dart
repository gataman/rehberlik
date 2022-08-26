library admin_main_view;

import 'dart:developer';

import 'package:rehberlik/models/trial_exam.dart';
import 'package:rehberlik/views/admin/admin_subjects/admin_subjects_binding.dart';
import 'package:rehberlik/views/admin/admin_trial_exam_detail/admin_trial_exam_result_binding.dart';
import 'package:rehberlik/views/admin/admin_trial_exam_detail/admin_trial_exam_result_view.dart';
import 'package:rehberlik/views/admin/admin_trial_exam_detail/components/admin_trial_exam_excel_import_view.dart';

import 'admin_main_view_imports.dart';

part 'components/side_menu.dart';

part 'components/header.dart';

part 'components/footer.dart';

class AdminMainView extends GetView<AdminMainViewController> {
  AdminMainView({Key? key}) : super(key: key);
  final _navigatorKey = Get.nestedKey(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldStateKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          children: [
            //Left SideMenu
            if (Responsive.isDesktop(context))
              const Expanded(child: SideMenu()),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Header(),
                  if (Responsive.isMobile(context))
                    const SizedBox(height: defaultPadding),
                  if (Responsive.isMobile(context)) const SearchField(),
                  Expanded(
                    child: _getNavigator(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getNavigator() {
    var pageRoute = GetPageRoute(
      page: () => AdminDashboardView(),
    );

    inspect(_navigatorKey);

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      height: 550,
      child: WillPopScope(
        onWillPop: () async {
          return !await didPopRoute();
        },
        child: Navigator(
          key: _navigatorKey,
          onGenerateRoute: (settings) {
            if (settings.name != null) {
              switch (settings.name!) {
                case Constants.routeDashboard:
                  pageRoute = GetPageRoute(
                    routeName: Constants.routeDashboard,
                    page: () => AdminDashboardView(),
                    binding: AdminDashboardViewBinding(),
                  );
                  break;
                case Constants.routeClasses:
                  pageRoute = GetPageRoute(
                    page: () => const AdminClassesView(),
                    binding: AdminClassesBinding(),
                  );
                  break;
                case Constants.routeStudents:
                  pageRoute = GetPageRoute(
                    page: () => const AdminStudentsView(),
                    binding: AdminStudentsBinding(),
                  );
                  break;
                case Constants.routeStudentDetail:
                  pageRoute = GetPageRoute(
                    page: () => const AdminStudentDetailView(),
                    binding: AdminStudentDetailBinding(),
                  );
                  break;
                case Constants.routeLessons:
                  pageRoute = GetPageRoute(
                    page: () => const AdminLessonsView(),
                    binding: AdminLessonsBinding(),
                  );
                  break;

                case Constants.routeSubjects:
                  final arguments = settings.arguments as Map<String, String>;

                  pageRoute = GetPageRoute(
                    page: () => Get.put(AdminSubjectsView(
                      lessonID: arguments['lessonID']!,
                      lessonName: arguments['lessonName']!,
                    )),
                    binding: Get.put(AdminSubjectsBinding()),
                  );
                  break;
                case Constants.routeMessages:
                  pageRoute = GetPageRoute(
                    page: () => const AdminMessageView(),
                    binding: AdminMessageBinding(),
                  );
                  break;

                case Constants.routeUploads:
                  pageRoute = GetPageRoute(
                    page: () => const AdminUploadsView(),
                    binding: AdminUploadsBinding(),
                  );
                  break;

                case Constants.routeTrialExams:
                  pageRoute = GetPageRoute(
                    page: () => const AdminTrialExamView(),
                    binding: AdminTrialExamBinding(),
                  );
                  break;

                case Constants.routeTrialExamResult:
                  pageRoute = GetPageRoute(
                      page: () => AdminTrialExamResultView(),
                      binding: AdminTrialExamResultBinding());

                  break;

                case Constants.routeTrialExamExcelImport:
                  pageRoute = GetPageRoute(
                    page: () => const AdminTrialExamExcelImportView(),
                  );
                  break;

                case '/':
                  pageRoute = GetPageRoute(
                    page: () => AdminDashboardView(),
                    binding: AdminDashboardViewBinding(),
                  );
                  break;
              }
            }
            return pageRoute;
          },
        ),
      ),
    );
  }

  Future<bool> didPopRoute() async {
    final NavigatorState? navigator = _navigatorKey!.currentState;
    assert(navigator != null);
    return await navigator!.maybePop();
  }
}
