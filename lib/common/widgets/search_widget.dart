import 'package:flutter/material.dart';

import '../constants.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const styleActive = TextStyle(color: Colors.white70);
    const styleHint = TextStyle(color: Colors.white70);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
      height: 40,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: style.color),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintStyle: const TextStyle(color: Colors.white30, fontSize: 14),
          hintText: "Öğrenci Arama",
          fillColor: darkSecondaryColor,
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}

/*
return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: TextField(
        decoration: InputDecoration(
            hintText: "Öğrenci Arama",
            hintStyle: const TextStyle(color: Colors.white30),
            fillColor: secondaryColor,
            filled: true,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            suffixIcon: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(defaultPadding * 0.75),
                margin:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: SvgPicture.asset("${iconsSrc}search.svg"),
                height: 20,
                width: 40,
              ),
            )),
      ),
    );
 */
