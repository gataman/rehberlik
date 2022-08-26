import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/models/school_student_stats.dart';

class SchoolStudentStatsCard extends StatelessWidget {
  const SchoolStudentStatsCard({
    Key? key,
    required this.schoolStudentStats,
  }) : super(key: key);

  final SchoolStudentStats schoolStudentStats;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("....");
      },
      child: Container(
        padding: const EdgeInsets.all(defaultPadding / 4),
        decoration: BoxDecoration(
          color: secondaryColor,
          border: Border.all(color: Colors.white10),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
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
                      Text(
                        schoolStudentStats.studentCount == 0
                            ? "..."
                            : "${schoolStudentStats.studentCount} Öğrenci",
                        style: const TextStyle(fontSize: 12),
                      )
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
}
