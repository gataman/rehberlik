import 'package:flutter/material.dart';

class DefaultCircularProgress extends StatelessWidget {
  const DefaultCircularProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          strokeWidth: 6,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
