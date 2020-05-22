import 'package:flutter/material.dart';
import 'package:habito/models/category.dart';
import 'package:habito/models/habit.dart';
import 'package:habito/models/universalValues.dart';
import 'package:habito/widgets/text.dart';

class HabitTile extends StatefulWidget {
  final int index;
  final MyHabit myHabit;
  final MyCategory myCategory;
  HabitTile(this.index, this.myHabit, this.myCategory);
  @override
  State<StatefulWidget> createState() {
    return _HabitTileState();
  }
}

class _HabitTileState extends State<HabitTile> {
  final EdgeInsets rightTileMargin = EdgeInsets.all(10);
  final EdgeInsets leftTileMargin = EdgeInsets.all(10);
  int _daysCompleted = 1;
  Widget something = Container();

  initState() {
    super.initState();
    if (widget.myHabit.daysCompleted == 0) {
      _daysCompleted = 0;
    } else {
      _daysCompleted = widget.myHabit.daysCompleted;
      new Future.delayed(Duration(milliseconds: 0)).then((_) {
        setState(() {
          widget.myHabit.daysCompleted = 21;
        });
      });
      new Future.delayed(Duration(milliseconds: 600)).then((_) {
        setState(() {
          widget.myHabit.daysCompleted = _daysCompleted;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double x = (MediaQuery.of(context).size.width / 2) - 35;
    double rightGap = x - 21;
    if (widget.myHabit.daysCompleted == 0) {
      rightGap = x;
    } else {
      rightGap -= (widget.myHabit.daysCompleted / 21) * rightGap;
    }

    return Container(
      decoration: BoxDecoration(
        color: HabitoColors.black,
      ),
      margin: widget.index % 2 == 0 ? leftTileMargin : rightTileMargin,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: HabitoColors.midnight,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(
              milliseconds: 700,
            ),
            curve: Curves.fastOutSlowIn,
            left: 0,
            top: 0,
            bottom: 0,
            right: rightGap,
            child: AnimatedContainer(
              duration: Duration(
                milliseconds: 700,
              ),
              decoration: BoxDecoration(
                color: widget.myCategory.categoryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(21),
                  bottomLeft: Radius.circular(21),
                  topRight:
                      Radius.circular(rightGap <= 21 ? (21 - rightGap) : 0),
                  bottomRight:
                      Radius.circular(rightGap <= 21 ? (21 - rightGap) : 0),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 18),
                CustomText(
                  widget.myHabit.title,
                  fontSize: 24,
                  letterSpacing: 0.2,
                ),
                SizedBox(height: 18),
                CustomText(
                  widget.myHabit.daysCompleted.toString() + " of 21 days done",
                  fontSize: 14,
                  letterSpacing: -0.3,
                  color: HabitoColors.captionWhite,
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
