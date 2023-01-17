import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/locator.dart';
import '../../../../../../models/subject.dart';
import '../../../../../../repository/subject_repository.dart';

part 'subject_list_state.dart';

class SubjectListCubit extends Cubit<SubjectListState> {
  SubjectListCubit() : super(SubjectListLoadingState());
  List<Subject>? _subjectList;

  final _subjectRepository = locator<SubjectRepository>();

  void setSubjectList({required List<Subject>? list}) {
    if (list != null) {
      // for (var i = 0; i < list.length; i++) {
      //   list[i].sort = i;
      // }
      _subjectList = list;
      // debugPrint(list.toString());
      emit(SubjectListLoadedState(_subjectList!));
    }
  }

  Future<String> addSubject(Subject subject) async {
    final subjectID = await _subjectRepository.add(object: subject);
    debugPrint('Add : $subject');
    subject.id = subjectID;
    _addSubjectInLocalList(subject);
    //_timeTableController.needUpdate = true;
    return subjectID;
  }

  Future<void> updateSubject(Subject subject) async {
    debugPrint('Update : $subject');
    return _subjectRepository.update(object: subject).then((value) {
      //_timeTableController.needUpdate = true;
      emit(SubjectListLoadedState(_subjectList!));
    });
  }

  Future<void> deleteSubject(Subject subject) {
    return _subjectRepository.deleteWithLessonID(objectID: subject.id!, lessonID: subject.lessonID!).then((value) {
      if (_subjectList != null) {
        _subjectList!.remove(subject);
        emit(SubjectListLoadedState(_subjectList!));
      }
    });
  }

  void _addSubjectInLocalList(Subject subject) {
    if (_subjectList != null) {
      _subjectList!.add(subject);
    } else {
      _subjectList = <Subject>[];
      _subjectList!.add(subject);
    }
    emit(SubjectListLoadedState(_subjectList!));
  }
}
