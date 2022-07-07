// Screen sizes:
import 'package:flutter/material.dart';

const primaryColor = Colors.teal;
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

const infoColor = Colors.teal;
const titleColor = Colors.amber;
const buttonColor = Colors.amber;
const warningColor = Colors.redAccent;

const defaultPadding = 16.0;
const mobileWidth = 600;
const tabletWidth = 850;
const desktopWidth = 1100;

const imagesSrc = "assets/images/";
const iconsSrc = "assets/icons/";

const defaultInfoStyle = TextStyle(
  color: infoColor,
  fontSize: 14,
  fontStyle: FontStyle.italic,
);

const defaultTitleStyle =
    TextStyle(color: titleColor, fontSize: 16, fontWeight: FontWeight.bold);

const studentListSmallStyle = TextStyle(fontSize: 12);

var defaultBoxDecoration = BoxDecoration(
  color: secondaryColor,
  border: Border.all(color: Colors.white10),
  borderRadius: const BorderRadius.all(
    Radius.circular(10),
  ),
);

const defaultDividerDecoration = BoxDecoration(
  color: secondaryColor,
  border: Border(bottom: BorderSide(color: Colors.white10)),
);
