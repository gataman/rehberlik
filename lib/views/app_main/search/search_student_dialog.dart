
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/widgets/search_widget.dart';
import 'package:rehberlik/models/student.dart';
import 'package:rehberlik/views/admin/admin_subjects/admin_subjects_imports.dart';

import '../../../common/navigaton/app_router/app_router.dart';
import 'cubit/search_student_cubit.dart';

class SearchStudentDialog extends StatelessWidget {
  const SearchStudentDialog({Key? key, required this.allStudentList, required this.mainContext}) : super(key: key);
  final List<Student> allStudentList;
  final BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: _getStudentSearchingList(context),
    );
  }

  Widget _getStudentSearchingList(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SearchWidget(
              text: 'Öğrenci Arama',
              onChanged: (value) {
                mainContext.read<SearchStudentCubit>().search(value);
              },
              hintText: 'Öğrenci Arama'),
          BlocBuilder<SearchStudentCubit, SearchStudentState>(
            builder: (context, state) {
              if (state is SearchStudentInitial) {
                final list = state.searchedStudentList;

                if (list != null) {
                  return _showSearchedList(list);
                  //return Text('ahahahha');
                } else {
                  return Text('Öğrenci bulunamadı');
                }
              } else {
                return Text('Öğrenci bulunamadı');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _showSearchedList(List<Student> searchedStudentList) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            final student = searchedStudentList[index];
            return InkWell(
                mouseCursor: SystemMouseCursors.click,
                hoverColor: Theme.of(context).dividerColor,
                onTap: () {
                  _showStudentDetail(student, context);
                },
                child: _studentListTile(student, context));
          },
          separatorBuilder: (context, index) => defaultDivider,
          itemCount: searchedStudentList.length),
    );
  }

  ListTile _studentListTile(Student student, BuildContext context) {
    return ListTile(
      leading: _setStudentLeading(student.photoUrl),
      title: Text(student.studentName!,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
      subtitle: Text(
        "Sınıfı: ${student.className.toString()} / No: ${student.studentNumber.toString()}",
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }

  Widget _setStudentLeading(String? photoUrl) {
    return photoUrl != null
        ? CircleAvatar(
            backgroundImage: NetworkImage(photoUrl),
          )
        : const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person),
          );
  }

  void _showStudentDetail(Student student, BuildContext context) {
    Navigator.of(context).pop();
    context.router.push(AdminStudentDetailRoute(student: student));
  }
}
