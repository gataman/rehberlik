import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../common/locator.dart';
import '../../../../../../models/trial_exam.dart';
import '../../../../../../repository/trial_exam_repository.dart';

part 'trial_exam_list_state.dart';

class TrialExamListCubit extends Cubit<TrialExamListState> {
  TrialExamListCubit() : super(TrialExamListState(selectedCategory: 5));

  final _trialExamRepository = locator<TrialExamRepository>();
  int selectedCategory = 8;

  List<TrialExam>? _trialExamList;

  void fetchTrialExamList() async {
    final _remoteList = await _trialExamRepository.getAll(filters: {'classLevel': selectedCategory});
    _trialExamList = _remoteList;
    _refreshList();
  }

  void changeCategory(int category) {
    selectedCategory = category;
    fetchTrialExamList();
  }

  void _refreshList() {
    emit(TrialExamListState(selectedCategory: selectedCategory, trialExamList: _trialExamList, isLoading: false));
  }

  Future<String> addTrialExam(TrialExam trialExam) async {
    final examID = await _trialExamRepository.add(object: trialExam);
    trialExam.id = examID;
    _addTrialExamInLocalList(trialExam);

    return examID;
  }

  Future<void> deleteTrialExam({required TrialExam trialExam}) async {
    return _trialExamRepository.delete(objectID: trialExam.id!).whenComplete(() {
      // editingLesson.value = null;
      _deleteTrialExamInLocalList(trialExam: trialExam);
    });
  }

  void _addTrialExamInLocalList(TrialExam trialExam) {
    if (_trialExamList != null) {
      _trialExamList!.add(trialExam);
    } else {
      _trialExamList = <TrialExam>[];
      _trialExamList!.add(trialExam);
    }
    _refreshList();
  }

  void _deleteTrialExamInLocalList({required TrialExam trialExam}) {
    _trialExamList!.remove(trialExam);
    _refreshList();
  }
}
