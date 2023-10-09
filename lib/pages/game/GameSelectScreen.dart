import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/pages/game/game.dart';

import '../getx.dart';






enum GameDifficulty { easy, medium, hard, impossible }


class DifficultySelectionPage extends StatefulWidget {
  @override
  _DifficultySelectionPageState createState() => _DifficultySelectionPageState();
}

class _DifficultySelectionPageState extends State<DifficultySelectionPage> {
  GameDifficulty selectedDifficulty = GameDifficulty.easy;


  // how to storer and get vakue from get
  // make this
  TapController controller  = Get.put(TapController());



  void _startGame() {
    int difficultyValue = selectedDifficulty.index;
    print('Selected Difficulty: $difficultyValue');

    //save get by this
    controller.save3(difficultyValue);
    //get vakue from egt by this
    print(controller.spd);
    GoRouter.of(context).go("/snakegame");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Color(0xff6499E9),
        title: Center(child: Text('Snake Game',style: TextStyle(fontSize: 22),)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RadioListTile<GameDifficulty>(
              title: Text('Easy'),
              value: GameDifficulty.easy,
              groupValue: selectedDifficulty,
              onChanged: (GameDifficulty? value) {
                setState(() {
                  selectedDifficulty = value!;
                });
              },
            ),
            RadioListTile<GameDifficulty>(
              title: Text('Medium'),
              value: GameDifficulty.medium,
              groupValue: selectedDifficulty,
              onChanged: (GameDifficulty? value) {
                setState(() {
                  selectedDifficulty = value!;
                });
              },
            ),
            RadioListTile<GameDifficulty>(
              title: Text('Hard'),
              value: GameDifficulty.hard,
              groupValue: selectedDifficulty,
              onChanged: (GameDifficulty? value) {
                setState(() {
                  selectedDifficulty = value!;
                });
              },
            ),
            RadioListTile<GameDifficulty>(
              title: Text('Impossible'),
              value: GameDifficulty.impossible,
              groupValue: selectedDifficulty,
              onChanged: (GameDifficulty? value) {
                setState(() {
                  selectedDifficulty = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                _startGame();
              },
              child: Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}
