import 'package:flutter/material.dart';
import 'package:rehberlik/views/admin/admin_study_program/components/student_program_data_grid_card.dart';

class AdminStudyProgramView extends StatelessWidget {
  const AdminStudyProgramView({Key? key}) : super(key: key);

  //region Properties

  //endregion

  //region Overrides
  @override
  Widget build(BuildContext context) {
    debugPrint("AdminStudy Build Çalıştı....");
    final _dateNow = DateTime.now();
    final _startTime = DateTime(_dateNow.year, _dateNow.month, _dateNow.day);
    const String _studentID = "4Vmdx0gLlcN8N0qaB1PB";

    return Column(
      children: [
        StudentProgramDataGridCard(studentID: _studentID, startTime: _startTime)
      ],
    );
  }
//endregion

//region Methods

//endregion
}
