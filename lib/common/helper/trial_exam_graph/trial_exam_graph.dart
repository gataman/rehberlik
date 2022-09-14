class TrialExamGraph {
  final String graphLabelName;
  final LessonType lessonType;
  final List<TrialExamGraphItem> itemList = [];

  TrialExamGraph({required this.graphLabelName, required this.lessonType});
}

class TrialExamGraphItem {
  final String itemName; //className
  final double value;

  TrialExamGraphItem({required this.itemName, required this.value});
}

enum LessonType { ten, twenty }

/*

enum LessonType{
  ten(10), 
  twenty(20),

  final int value; 
  const LessonType(this.value);

}

*/
