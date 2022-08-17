part of admin_main_view;

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding:
          const EdgeInsets.only(right: defaultPadding, top: defaultPadding),
      width: double.infinity,
      child: const Text(
        "",
        // "© Copyright 2022 - Gürcan Ataman",
        style: TextStyle(
            fontSize: 10, fontStyle: FontStyle.italic, color: Colors.white38),
        textAlign: TextAlign.end,
      ),
    );
  }
}
