import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/models/school_student_stats.dart';

class SchoolStudentStatsCard extends StatelessWidget {
  const SchoolStudentStatsCard({
    Key? key,
    required this.schoolStudentStats,
  }) : super(key: key);

  final SchoolStudentStats schoolStudentStats;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: FittedBox(
                  child: Text(
                    "${schoolStudentStats.classLevel}.",
                    style: TextStyle(
                      fontSize: 36,
                      color: schoolStudentStats.classColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "SINIFLAR",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      schoolStudentStats.studentList == null
                          ? _getAnimatedTextView()
                          : Text("${schoolStudentStats.studentList!.length} Öğrenci",
                              style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getAnimatedTextView() {
    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 12.0,
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          WavyAnimatedText('...', textStyle: const TextStyle(fontSize: 12, color: Colors.white)),
        ],
        isRepeatingAnimation: true,
      ),
    );
  }
}
