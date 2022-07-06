import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/models/class_stats.dart';

class ClassStatsCard extends StatelessWidget {
  const ClassStatsCard({
    Key? key,
    required this.classStats,
  }) : super(key: key);

  final ClassStats classStats;

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
                    "${classStats.classLevel ?? ''}.",
                    style: TextStyle(
                      fontSize: 36,
                      color: classStats.classColor ?? primaryColor,
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
                    children: const [
                      Text(
                        "SINIFLAR",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "128 Öğrenci",
                        style: TextStyle(fontSize: 12),
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
