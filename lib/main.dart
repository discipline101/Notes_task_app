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
      theme: blueTheme,
      routerConfig: router,


    );
  }
}



final ThemeData blueTheme = ThemeData(
  primaryColor: Colors.blue,
  hintColor: Colors.blueAccent,
  scaffoldBackgroundColor: Colors.blue.shade50,
  appBarTheme: AppBarTheme(
    color: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.blue,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colors.blue.shade50),


  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue.shade400, // Text color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5), // Makes the button rectangular
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5), // Makes the button rectangular
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.blue,
      side: BorderSide(color: Colors.blue), // Border color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5), // Makes the button rectangular
      ),
    ),
  ),


  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue.shade400), // Border color
      borderRadius: BorderRadius.circular(5), // Rectangle shape
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue), // Focused border color
      borderRadius: BorderRadius.circular(5), // Rectangle shape
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue.shade400), // Enabled border color
      borderRadius: BorderRadius.circular(5), // Rectangle shape
    ),
    hintStyle: TextStyle(color: Colors.blueAccent), // Hint text color
    labelStyle: TextStyle(color: Colors.blue), // Label text color
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red), // Error border color
      borderRadius: BorderRadius.circular(5), // Rectangle shape
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red), // Error border color
      borderRadius: BorderRadius.circular(5), // Rectangle shape
    ),
  ),



);
