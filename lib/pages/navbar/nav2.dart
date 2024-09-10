

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Nav2 extends StatefulWidget {
  const Nav2({super.key});

  @override
  State<Nav2> createState() => _Nav2State();
}

class _Nav2State extends State<Nav2> {
  final _pgcontroller = PageController(initialPage: 0);
  final _cntrlr = NotchBottomBarController(index: 0);
int i=0;


  @override
  Widget build(BuildContext context) {
    return AnimatedNotchBottomBar(
        notchBottomBarController: _cntrlr,
        color: Colors.lightBlueAccent,
        kIconSize: 10,
        durationInMilliSeconds: 170,
        showBlurBottomBar: true,

        bottomBarWidth: 1000,
        bottomBarItems: [


         const BottomBarItem(
            activeItem: Icon(Icons.task),
            inActiveItem: Icon(Icons.task_outlined),
            itemLabel: "0"
          ),
        const  BottomBarItem(
              activeItem: Icon(Icons.task),
              inActiveItem: Icon(Icons.task_outlined),
              itemLabel: "1"
          ),
        const  BottomBarItem(
              activeItem: Icon(Icons.task),
              inActiveItem: Icon(Icons.task_outlined),
              itemLabel: "2"
          ),




        ],
        onTap: (index){
          setState(() {
            _pgcontroller.jumpToPage(index);
            print(i);
            print(index);
            i= index;
            // i==0?GoRouter.of(context).go("/task"):i==1?GoRouter.of(context).go("/calender"):GoRouter.of(context).go("/appointmentlist");
          });
        }, kBottomRadius: 10,
    );
  }
}
