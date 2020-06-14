import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:habito/models/enums.dart';
import 'package:habito/state/habitoModel.dart';
import 'package:habito/models/universalValues.dart';
import 'package:habito/pages/allCategories.dart';
import 'package:habito/pages/allHabits.dart';
import 'package:habito/pages/profile.dart';
import 'package:habito/widgets/category/categoryModal.dart';
import 'package:habito/widgets/general/addNewModal.dart';
import 'package:habito/widgets/general/confettiExplosionBox.dart';
import 'package:habito/widgets/myBottomBar.dart';
import 'package:habito/widgets/habit/habitModal.dart';

class Home extends StatefulWidget {
  final HabitoModel model;
  Home(this.model);
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int currentPage = 0;
  static PageController controller = PageController(
    initialPage: 0,
  );
  ConfettiController _confettiController;

  void startConfetti() {
    _confettiController.play();
  }

  void initState() {
    _confettiController =
        ConfettiController(duration: Duration(milliseconds: 100));
    widget.model.playConfetti = startConfetti;
    super.initState();
  }

  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void changeScreen(int pageNo) {
    setState(() {
      currentPage = pageNo;
    });
    controller.animateToPage(pageNo,
        duration: Duration(milliseconds: 400), curve: Curves.easeOutCirc);
  }

  void addNewHabit(BuildContext context) {
    Navigator.of(context).pop();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext _context) {
        return HabitModal(HabitModalMode.NEW);
      },
    );
  }

  void addNewCategory(BuildContext context) {
    Navigator.of(context).pop();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext _context) {
        return CategoryModal(CategoryModalMode.NEW);
      },
    );
  }

  void addNewExport(BuildContext context) {
    widget.model.showAlert(
      context,
      MyStrings.newFeatureTeaseHeading,
      MyStrings.newFeatureTeaseBody,
    );
  }

  void showMyBottomModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext _context) {
        return AddNewModal(addNewHabit, addNewCategory, addNewExport);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: MyColors.black,
      body: Stack(
        children: <Widget>[
          PageView(
            controller: controller,
            onPageChanged: (int pageNo) {
              setState(() {
                currentPage = pageNo;
              });
            },
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              AllHabits(false),
              AllCategories(),
              AllHabits(true),
              Profile(),
            ],
          ),
          ConfettiExplosionBox(_confettiController),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMyBottomModal(context);
        },
        backgroundColor: MyColors.white,
        child: Icon(
          Icons.add,
          color: MyColors.perfectBlue,
          size: UniversalValues.plusIconSize,
        ),
      ),
      bottomNavigationBar: MyBottomBar(currentPage, changeScreen),
    );
  }
}
