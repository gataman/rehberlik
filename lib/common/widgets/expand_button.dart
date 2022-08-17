import 'package:rehberlik/views/admin/admin_main_view/admin_main_view_imports.dart';

class ExpandButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isHorizontal;
  final bool isExpanded;

  const ExpandButton(
      {Key? key,
      required this.onPressed,
      required this.isHorizontal,
      required this.isExpanded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.only(
            top: isHorizontal ? defaultPadding : 0,
            bottom: !isHorizontal
                ? !isExpanded
                    ? 4
                    : 0
                : 0),
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Container(
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(isExpanded
                        ? isHorizontal
                            ? 5
                            : 5
                        : 0),
                    bottomRight: Radius.circular(isExpanded
                        ? isHorizontal
                            ? 5
                            : 0
                        : isHorizontal
                            ? 0
                            : 5),
                    topLeft: Radius.circular(isExpanded
                        ? isHorizontal
                            ? 0
                            : 5
                        : isHorizontal
                            ? 5
                            : 0),
                    bottomLeft: Radius.circular(isExpanded ? 0 : 5)),
              ),
              width: isHorizontal ? 16 : 48,
              height: isHorizontal ? 48 : 16,
              child: Padding(
                padding: EdgeInsets.only(right: isHorizontal ? 8 : 0),
                child: Icon(
                  isHorizontal
                      ? isExpanded
                          ? Icons.keyboard_arrow_left
                          : Icons.keyboard_arrow_right
                      : isExpanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                  size: 16,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
