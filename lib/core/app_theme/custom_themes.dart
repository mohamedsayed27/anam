import 'package:flutter/material.dart';

class CustomThemes {

  static TextStyle whiteColorTextTheme(context) =>
      Theme.of(context).textTheme.titleLarge!;

  static TextStyle greyD9ColorTextTheme(context) =>
      Theme.of(context).textTheme.titleSmall!;

  static TextStyle darkGreyColorTextTheme(context) =>
      Theme.of(context).textTheme.headlineSmall!;

  static TextStyle grey7DColorTextTheme(context) =>
      Theme.of(context).textTheme.labelLarge!;

  static TextStyle primaryColorTextTheme(context) =>
      Theme.of(context).textTheme.titleMedium!;

  static TextStyle greyColor34TextTheme(context) =>
      Theme.of(context).textTheme.bodyLarge!;
}