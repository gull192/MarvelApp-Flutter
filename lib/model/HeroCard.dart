// ignore: file_names
import 'package:flutter/material.dart';

class HeroCard {
  late String photo;
  late String heroName;
  late Color backgroungColor;
  HeroCard (String photo, String heroName, Color backgroundColor) {
    this.backgroungColor = backgroundColor;
    this.heroName = heroName;
    this.photo = photo;
  }
}