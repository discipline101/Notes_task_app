
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}





class _StartScreenState extends State<StartScreen> {



  @override
  Widget build(BuildContext context) {

    Timer(
      Duration(seconds : 5),
        ()=> GoRouter.of(context).go("/task")

    );


    return Scaffold(
      body: Center(
        child: Container(
child: Image(image: NetworkImage('https://cdn.dribbble.com/users/4241563/screenshots/11874468/media/7796309c77cf752615a3f9062e6a3b3d.gif'),),
        ),
      ),
    );
  }
}

