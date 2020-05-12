import 'package:flutter/material.dart';
import 'package:habito/models/habit.dart';
import 'package:habito/widgets/text.dart';

class MyCategory {
  String _name;
  List<MyHabit> _myHabits;
  int _color;
  IconData _icon;
  final List<Color> colors = [
    Colors.blue,
    Colors.orange,
    Colors.deepOrange,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo
  ];

  MyCategory() {
    this._myHabits = [];
    this._color = 0;
    this._icon = Icons.label_outline;
    this._name = "";
  }

  set categoryName(String name) {
    this._name = name;
  }

  set categoryColor(int color) {
    this._color = color;
  }

  set categoryIcon(IconData icon) {
    this._icon = icon;
  }

  get categoryName {
    return _name;
  }

  get categoryHabits {
    return _myHabits;
  }

  get categoryColor {
    return _color;
  }

  get categoryIcon {
    return _icon;
  }

  Widget widget() {
    //Color(0xff1F2024)
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        color: Color(0xff1F2024),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            _icon,
            color: colors[_color],
            size: 30,
          ),
          SizedBox(
            width: 9,
          ),
          CustomText(
            _name,
            fontSize: 21,
            letterSpacing: 0.2,
          ),
        ],
      ),
    );
  }
}
