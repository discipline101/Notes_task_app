
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class nav extends StatefulWidget {
  const nav({super.key});

  @override
  State<nav> createState() => _navState();
}

class _navState extends State<nav> {
  int i=0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

      backgroundColor: Color(0xff6499E9),
      fixedColor: Colors.blue.shade50,
      onTap: (index){
setState(() {
  i=index;
  i==0?GoRouter.of(context).go("/task"):i==1?GoRouter.of(context).go("/calender"):GoRouter.of(context).go("/appointmentlist");
});
      },
      currentIndex: i,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.add_task_outlined),
            label: "Task",

        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_sharp),
            label: "Calender"),
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Schedule"),
      ],);
  }
}
