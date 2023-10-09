// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/pages/ThirdNavbarOption/AppointmentsList.dart';
// import 'package:notes/pages/appointmentlist/AppointmentsList.dart';
import 'package:notes/pages/calander.dart';
import 'package:notes/pages/calender/meeting.dart';
import 'package:notes/pages/game/GameSelectScreen.dart';
import 'package:notes/pages/game/game.dart';
import 'package:notes/pages/getx.dart';
import 'package:notes/pages/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:notes/pages/navbar/nav.dart';
import 'package:notes/pages/navbar/nav2.dart';
import 'package:notes/pages/navbar/nav3.dart';
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






  runApp(MyApp());

}


class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  TapController controller  = Get.put(TapController());
  @override
  Widget build(BuildContext context) {
    // GoRouter.of(context).go("/start");

int myindex=0;
    GoRouter router = GoRouter(routes: [
      GoRoute(
          path: "/",
        // path: "/change ti later",
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

        GoRoute(
            path: "/appointmentlist",
          // path: "/",
            builder: (context,state)=> AppointmentList()
        ),

        GoRoute(
          path: "/snakegame",
          // path: "/",
          // builder: (context,state)=> DifficultySelectionPage(),
          builder: (context,state)=> SnakeGame(controller.spd),
        ),

        GoRoute(
          path: "/selectionscreen",
          // path: "/",
          builder: (context,state)=> DifficultySelectionPage(),
          // builder: (context,state)=> ,
        ),


      ],
      builder: (context,state,child){
        return Scaffold(
          body: child,
          backgroundColor: Colors.blue.shade50,
          bottomNavigationBar:nav3()
        );
      }
      ),



    ]);
    return MaterialApp.router(

    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Colors.blue,
      fontFamily: "exo-light"
      // textTheme: GoogleFonts.exo(),
    ),

      routerConfig: router,


    );
  }
}
