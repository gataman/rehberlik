import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/containers/app_list_box_container.dart';
import '../../../../core/widgets/text/app_box_title.dart';
import '../../../../models/helpers/lesson_with_subject.dart';
import '../../../../models/lesson_source.dart';

import '../../../../common/constants.dart';
import '../../../../common/widgets/default_circular_progress.dart';
import '../../../../models/subject.dart';
import '../cubit/lesson_sources_cubit.dart';
import 'lesson_sources_data_table2.dart';

class StudentLessonSourcesContainerView extends StatelessWidget {
  const StudentLessonSourcesContainerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBoxContainer(
      child: Column(
        children: [
          const AppBoxTitle(title: 'Öğrenci Kaynak Takibi', isBack: false),
          BlocBuilder<LessonSourcesCubit, LessonSourcesState>(
            builder: (context, state) {
              if (state is StudentLessonSourcesSelectedStade) {
                return GestureDetector(
                    onTap: () {
                      List<String> subjectList = ['birinci', 'ikinci', 'ucuncu'];
                      LessonSource lessonSource = LessonSource(
                          studentId: state.student.id,
                          lessonId: '1234mmm',
                          sourcesName: 'Hız Yayınları',
                          subjectList: subjectList);
                      context.read<LessonSourcesCubit>().saveStudentResources(lessonSource: lessonSource);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: _setLessonSources(state.mapList),
                    ));
              } else {
                return const SizedBox(height: minimumBoxHeight, child: DefaultCircularProgress());
              }
            },
          )
        ],
      ),
    );
  }

  List<Widget> _setLessonSources(List<Map<String, dynamic>> mapList) {
    List<Widget> widgetList = [];
    for (var map in mapList) {
      widgetList.add(LessonSourcesDataTable2(resourceMap: map));
    }

    return widgetList;
  }
}

class LessonAndSourceTable extends StatelessWidget {
  const LessonAndSourceTable({Key? key, required this.resourceMap}) : super(key: key);
  final Map<String, dynamic> resourceMap;

  @override
  Widget build(BuildContext context) {
    final lessonAndSubject = resourceMap['lessonWithSubject'] as LessonWithSubject;
    final resourceList = resourceMap['lessonResourceList'] as List<LessonSource>;

    final Map<int, TableColumnWidth> tableColumnWithList = {
      0: const FixedColumnWidth(150),
    };

    tableColumnWithList[1] = const FixedColumnWidth(80);

    for (var i = 0; i < 15; i++) {
      tableColumnWithList[i + 2] = const FixedColumnWidth(80);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lessonAndSubject.lesson.lessonName ?? 'Ders Adı'),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    columnWidths: tableColumnWithList,
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.all(color: Theme.of(context).dividerColor),
                    children: [
                      _setTableSubTitle(resourceList),
                      if (lessonAndSubject.subjectList != null)
                        for (var subject in lessonAndSubject.subjectList!) _setValueRow(resourceList, subject),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow _setTableSubTitle(List<LessonSource> resourceList) {
    return TableRow(children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Konular'),
      ),
      for (var resource in resourceList)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(resource.sourcesName ?? ''),
        ),
      for (var i = 0; i < 15; i++)
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('...'),
        ),
    ]);
  }

  _setValueRow(List<LessonSource> resourceList, Subject subject) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('${subject.subject}'),
      ),
      for (var _ in resourceList)
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('.'),
        ),
      for (var i = 0; i < 15; i++)
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('...'),
        ),
    ]);
  }
}
