import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../pages/calender/meeting.dart';
import 'dart:developer' as devlog;




class calenDB{
  List<Meeting>? meetings = <Meeting>[];
  List<Meeting> meetings2 = <Meeting>[];
  List<dynamic> meetings3 = <dynamic>[];

  //for apponi=tmentlist
  List appointmentlist = [];

//reference box
  final box2 = Hive.box("box2");

void boat(){
  box2.delete("CALENDERLIST");
}

  void loaddb(){
    if(box2.get("CALENDERLIST")!=null) {
      meetings3 = box2.get("CALENDERLIST");
      print("meetings check length");


      if (meetings3 != null) {
        print("the real length===============================================");
        print(meetings3.length);

        for (int i = 0; i < meetings3.length; i++) {
          print(i);
          meetings?.add(Meeting(
            meetings3[i].from, meetings3[i].to, meetings3[i].eventName,
            meetings3[i].isAllDay,));
        }
        // print(meetings3[0][2].eventName);
        // meetings = meetings3;
      }
    }
  }


  //for list of appointents
  List initialiseappointments(){
    // meetings3?.add(box2.get("CALENDERLIST"));
    if(box2.get("CALENDERLIST")!=null) {
      meetings3 = box2.get("CALENDERLIST");
    }

    print("meetings check length");



    if(meetings3 !=null ) {
      print("length is=====================================================");
      // print((meetings3[0][9));
      appointmentlist = [];

      for (int i = 0; i < meetings3.length; i++) {
        print(i);
        String day =   (meetings3[i].from.day).toString() +"-"+(meetings3[i].from.month).toString()+"-" +(meetings3[i].from.year).toString();
        // if(meetings3[0][i][0]!=null) {
        final a =(meetings3[i]);
          // print(devlog.);
// devlog.log(a.toString());
          appointmentlist.add(
            [
              (meetings3[i].eventName).toString(),
              false,
               day,
              ( meetings3[i].from).toString().substring(10,16),
              (meetings3[i].to).toString().substring(11,16),
              (meetings3[i].from).toString()


            ]
          );




      }
      // print(meetings3[0][2].eventName);
      // meetings = meetings3;
    }

    print("this is from c db");
    print(appointmentlist);

    return appointmentlist;


  }



  void delete(int index){
  meetings3.removeAt(index);
  box2.put("CALENDERLIST", meetings3);
  loaddb();
  }

  void updatedb2(){

    box2.put("CALENDERLIST", meetings3);
    loaddb();
  }


  void updatedb(){
    box2.put("CALENDERLIST", meetings);
  }





  // void loaddb2(){
  //   meetings2 = box2.get("CALENDERLIST2");
  // }
  //
  // void updatedb2(){
  //   box2.put("CALENDERLIST2", meetings2);
  // }

}



// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import '../pages/calender/meeting.dart';
//
// class calenDB {
//   List<Meeting>? meetings = <Meeting>[];
//   List<Meeting> meetings2 = <Meeting>[];
//   List<dynamic> meetings3 = <dynamic>[];
//   List<dynamic> appointmentList = [];
//
//   final box2 = Hive.box("box2");
//
//   void loaddb() {
//     meetings3 = box2.get("CALENDERLIST");
//     print("Checking calendar data length");
//
//     if (meetings3 != null) {
//       print("The real calendar data length: ${meetings3.length}");
//       meetings?.clear();
//       for (int i = 0; i < meetings3.length; i++) {
//         meetings?.add(Meeting(
//           meetings3[i].from,
//           meetings3[i].to,
//           meetings3[i].eventName,
//           meetings3[i].isAllDay,
//         ));
//       }
//     }
//   }
//
//   List<dynamic> initialiseappointments() {
//     meetings3?.add(box2.get("CALENDERLIST"));
//     print("Checking calendar data length");
//
//     if (meetings3[0] != null) {
//       print("Calendar data length: ${meetings3[0].length}");
//       appointmentList.clear();
//
//       for (int i = 0; i < meetings3[0].length; i++) {
//         String day =
//             "${meetings3[0][i].from.day}-${meetings3[0][i].from.month}-${meetings3[0][i].from.year}";
//         final meetingData = meetings3[0][i];
//         appointmentList.add([
//           meetingData.eventName.toString(),
//           false,
//           day,
//           meetingData.from.toString().substring(10, 16),
//           meetingData.to.toString().substring(11, 16),
//           meetingData.from.toString(),
//         ]);
//       }
//     }
//
//     return appointmentList;
//   }
//
//   void updatedb() {
//     box2.put("CALENDERLIST", meetings);
//   }
//
//   void loaddb2() {
//     meetings2 = box2.get("CALENDERLIST2");
//   }
//
//   void updatedb2() {
//     box2.put("CALENDERLIST2", meetings2);
//   }
//
//   // Method to delete an appointment by index
//   void deleteAppointment(int index) {
//     if (index >= 0 && index < appointmentList.length) {
//       appointmentList.removeAt(index);
//       // After removing the appointment from the list, update the Hive database
//       updateDatabase();
//     }
//   }
//
//   // Method to update the Hive database with the updated appointmentList
//   void updateDatabase() {
//     box2.delete("CALENDERLIST");
//     box2.put("CALENDERLIST", appointmentList);
//   }
// }
