import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../common/extensions.dart';
import '../../../../../../../common/locator.dart';
import '../../../../../../../models/question_follow.dart';
import '../../../../../../../repository/question_follow_repository.dart';

part 'question_follow_list_state.dart';

class QuestionFollowListCubit extends Cubit<QuestionFollowListState> {
  QuestionFollowListCubit() : super(QuestionFollowListState());

  final QuestionFollowRepository _questionFollowRepository = locator<QuestionFollowRepository>();
  List<QuestionFollow>? questionFollowList;

  Future<List<QuestionFollow>?> fetchQuestionFollowList({required String studentID, DateTime? startTime}) async {
    if (startTime == null) {
      final dateNow = DateTime.now();
      startTime = DateTime(dateNow.year, dateNow.month, dateNow.day);
    }

    final localList = <QuestionFollow>[];
    for (var i = 0; i < 7; i++) {
      final date = startTime.add(Duration(days: i));
      final questionFollow = QuestionFollow(studentID: studentID, date: date);
      localList.add(questionFollow);
    }

    final endTime = startTime.add(const Duration(days: 6));

    var remoteList =
        await _questionFollowRepository.getAll(studentID: studentID, startTime: startTime, endTime: endTime);

    if (remoteList != null && remoteList.isNotEmpty) {
      var i = 0;
      for (var localQuestionFollow in localList) {
        var findingQuestionFollow = remoteList.findOrNull((element) => element.date == localQuestionFollow.date);
        if (findingQuestionFollow != null) {
          localList[i] = findingQuestionFollow;
        }
        i++;
      }
    }

    questionFollowList = localList;
    _refreshList();
    return questionFollowList;
  }

  Future<String?> changeQuestionFollow({required QuestionFollow questionFollow}) async {
    if (questionFollow.id == null) {
      return await _questionFollowRepository.add(object: questionFollow);
    } else {
      _questionFollowRepository.update(object: questionFollow);
      return null;
    }
  }

  void _refreshList() {
    emit(QuestionFollowListState(isLoading: false, questionFollowList: questionFollowList));
  }
}
