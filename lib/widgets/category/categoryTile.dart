import 'package:flutter/material.dart';
import 'package:habito/models/universalValues.dart';
import 'package:habito/widgets/text.dart';

class CategoryTile extends StatelessWidget {
  final bool showNumberOfHabits;
  final List<String> myHabits;
  final IconData icon;
  final int color;
  final String name;
  CategoryTile(
    this.showNumberOfHabits,
    this.myHabits,
    this.icon,
    this.color,
    this.name,
  );

  @override
  Widget build(BuildContext context) {
    Widget onTheRight = Container();
    double _rightPadding = 0;
    if (showNumberOfHabits) {
      onTheRight = Expanded(
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 36,
            height: 36,
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                myHabits.length.toString(),
                fontSize: 18,
              ),
            ),
            decoration: BoxDecoration(
              color: HabitoColors.labelBackground,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );
    }
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        color: HabitoColors.midnight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: HabitoColors.standardColorsList[color],
            size: 30,
          ),
          SizedBox(
            width: 9,
          ),
          Padding(
            padding: EdgeInsets.only(right: _rightPadding),
            child: CustomText(
              name,
              fontSize: 21,
              letterSpacing: 0.2,
            ),
          ),
          onTheRight
        ],
      ),
    );
  }
}
