// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/pages/calander.dart';
import 'package:notes/pages/calender/meeting.dart';
import 'package:notes/pages/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:notes/pages/nav.dart';
import 'package:notes/pages/start.dart';

void main() async {


  //initialising hive
  await Hive.initFlutter();

  //registering custom adapter
  // Hive.registerAdapter(MeetingAdapter());
    Hive.registerAdapter(MeetingAdapter());
//opening box so we can reference later
  var box = await  Hive.openBox("box");
  var box2 = await  Hive.openBox("box2");


// SystemChrome.setEnabledSystemUIMode(SystemUiOverlay.bottom);
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Set status bar color to transparent.
    statusBarIconBrightness: Brightness.light, // Set the status bar icons to be dark.

  ));






  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // GoRouter.of(context).go("/start");

int myindex=0;
    GoRouter router = GoRouter(routes: [
      GoRoute(path: "/",
      builder: (context,state)=>StartScreen()
      ),
      ShellRoute(routes: [


        GoRoute(
            path: "/calender",
          builder: (context,state)=>Calander()
        ),

        GoRoute(
            path: "/task",
            builder: (context,state)=>HomePage()
        ),

        // GoRoute(
        //     path: "/idk",
        //     builder: (context,state)=>
        // ),


      ],
      builder: (context,state,child){
        return Scaffold(
          body: child,
          bottomNavigationBar:nav()
        );
      }
      ),



    ]);
    return MaterialApp.router(

    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: router,


    );
  }
}
