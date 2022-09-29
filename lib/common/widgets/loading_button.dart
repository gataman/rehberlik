import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final Color? backColor;
  final Color? textColor;
  final String text;
  final IconData iconData;
  final ValueNotifier<bool> loadingListener;
  final VoidCallback onPressed;

  const LoadingButton(
      {Key? key,
      this.backColor,
      this.textColor,
      this.iconData = Icons.save,
      required this.text,
      required this.loadingListener,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backColor ?? Theme.of(context).primaryColor,
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            ValueListenableBuilder(
                valueListenable: loadingListener,
                builder: (context, isLoading, child) {
                  if (isLoading as bool) {
                    return SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: textColor ?? Theme.of(context).colorScheme.onPrimary,
                        ));
                  } else {
                    return SizedBox(
                        child: Icon(
                      iconData,
                      color: textColor ?? Theme.of(context).colorScheme.onPrimary,
                    ));
                  }
                }),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      color: textColor ?? Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ));
  }
}
