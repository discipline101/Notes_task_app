


import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class nav3 extends StatefulWidget {
  const nav3({super.key});
  @override
  State<nav3> createState() => _nav3State();
}

class _nav3State extends State<nav3> {
  int i=0;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Padding(

        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1),
          child: Container(
            height: 60,
            child: CurvedNavigationBar(
              color: Colors.blue.shade300,
              animationDuration: Duration(milliseconds: 550),
              animationCurve: Curves.easeInOutCirc,
              // animationCurve: Curves.easeInOutExpo,
              backgroundColor: Colors.blue.shade50,
              onTap: (index){

                setState(() {
                  i=index;
                  i==0?GoRouter.of(context).go("/task"):i==1?GoRouter.of(context).go("/calender"):i==2?GoRouter.of(context).go("/appointmentlist"):GoRouter.of(context).go("/selectionscreen");
                });
              },
              height: 50,
              items: [
                Icon(Icons.task_alt,color: Colors.white),
                Icon(CupertinoIcons.calendar,color: Colors.white,),
                Icon(Icons.list,color: Colors.white,),
                Icon(CupertinoIcons.game_controller,color: Colors.white,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
