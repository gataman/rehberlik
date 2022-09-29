import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppSmallRoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  IconData iconData;
  Color bgColor;

  AppSmallRoundedButton({
    Key? key,
    required this.onPressed,
    this.iconData = Icons.edit,
    this.bgColor = Colors.lightGreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      color: bgColor, // button color
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        hoverColor: Colors.white54,
        splashColor: Colors.black26,
        onTap: onPressed,
        // inkwell color
        child: SizedBox(
            width: 28,
            height: 28,
            child: Icon(
              iconData,
              size: 16,
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(.7),
            )),
      ),
    );
  }
}
