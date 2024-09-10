
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:notes/db/calenderDB.dart';
import 'package:notes/pages/calender/meeting.dart';
import 'package:notes/pages/calender/meeting_ds.dart';
import 'package:notes/pages/getx.dart';
import 'package:notes/pages/popup/popup_calender.dart';
import 'package:popover/popover.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'meetingds.dart';
class Calander extends StatefulWidget {
  const Calander({super.key});

  @override
  State<Calander> createState() => _CalanderState();
}




class _CalanderState extends State<Calander> {
  var _i=2;
  DateTime? date,date2;
  TimeOfDay? time,time2;
  String? a11,a12,a21,a22;
  int? b11,b12,b21,b22;
  // final meetings a = meetings();
  CalendarController calendercntrl = CalendarController();
  late  List<Meeting>? meetings = <Meeting>[];
  late final datasource;



  String getViewName(CalendarView view) {
    switch (view) {
      case CalendarView.day:
        return "Day Wise";
      case CalendarView.week:
        return "Week Wise";
      case CalendarView.month:
        return "Month Wise";
      case CalendarView.timelineDay:
        return "Timeline-Day Wise";
      case CalendarView.timelineWeek:
        return "Timeline-Week Wise";
      case CalendarView.timelineMonth:
        return "Timeline-Month Wise";
      case CalendarView.workWeek:
        return "Work-Week Wise";
      case CalendarView.schedule:
        return "Schedule";
      default:
        return "Unknown";
    }
  }
  List<Meeting>? _getDS(name,year,month,day,hr1,min1,hr2,min2){
  // final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(year,month,day,hr1,min1,0);
  final DateTime endTime =   DateTime(year,month,day,hr2,min2,0);
  setState(() {
    meetings!.add(Meeting( startTime, endTime, name,false));
    // final a = calendb.meetings;
    // if(a!=null) {
    //   a.add(Meeting(startTime, endTime, name, const Color(0xFF0F8644), false));
    // }
    calendb.meetings = meetings;
    //hiiiiii
    print("calendb met------------------------------------------------------------------------------------------------------------------------------------------------");
    print(calendb.meetings);
    calendb.updatedb();
  });
  print("added to list--------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
  print(meetings);
  return meetings;
  }






  final _cntrl3 = TextEditingController();


  final box2 = Hive.box("box2");
  calenDB calendb = calenDB();


@override
  void initState(){
    // TODO: implement initState

  print("--------------------------------------------------------------------------------------------------------------------------------------start");
  print(calendb.meetings);
  if(calendb.meetings !=null) {
    calendb.loaddb();
    meetings = calendb.meetings;
  }
    super.initState();
  }



  // void save(){
  //
  //
  // }


String starttime(){

  return ("${a11}:${b12}");
}



  //
  // void popup3(){
  //
  //  ;
  //   print("date is");
  //   print(date2);
  // }




void viewchange(int? a){

}







List items =[
  "a",
  "b",
  "c"
];

final List calenderview = [
  CalendarView.day,
  CalendarView.week,
  CalendarView.month,
  CalendarView.timelineDay,
  CalendarView.timelineWeek,
  CalendarView.timelineMonth,
  CalendarView.workWeek,
  CalendarView.schedule
];

int? apple(){
  return b12;
}


void apple2()async{
  time = await showTimePicker(context: context, initialTime: TimeOfDay.now());

}

int? _value=1;



int calenview(int iii){
  print("yoohoo");
  print(iii);
  return iii;
}





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xff6499E9),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 22,),

            Center(
                child: Text("CALENDER",style: TextStyle(fontSize: 22,color: Colors.white),)),


            PopupMenuButton<CalendarView>(
          // icon: Icon(CupertinoIcons.app_badge_fill),
        initialValue: calendercntrl.view,
          itemBuilder: (BuildContext context) {
            return CalendarView.values
                .where((view) => getViewName(view) != "Unknown")
                .map((view) {
              return PopupMenuItem<CalendarView>(
                value: view,
                child: Text(getViewName(view)),
              );
            }).toList();
          },
          onSelected: (newValue) {
            setState(() {
              calendercntrl.view = newValue!;
            });
          },
          child: Icon(Icons.remove_red_eye_outlined),
        ),

          ],
        ),),




      floatingActionButton: FloatingActionButton(
        onPressed: ()=> showDialog(
            context: context,
            builder: (context){
              //accessing controller from out
              TapController controller  = Get.put(TapController());


              return  GetBuilder<TapController>(
                builder : (tapcntrl) {
                 return AlertDialog(
                    backgroundColor: Colors.blue[100],
                    content: SingleChildScrollView(
                      child: Container(
                        height: 370,
                        child: Column(
                          children: [
                            Container(height: 40,
                              child: Text("ADD TASK",
                                style: TextStyle(color: Colors.black,
                                  fontSize: 20,

                                ),

                              ),

                            ),
                            TextField(controller: _cntrl3,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Write a task...",),
                              cursorColor: Colors.black,),
                            SizedBox(height: 15,),

                            SizedBox(
                              width: 40,
                              child: MaterialButton(onPressed: () async {
                                setState(() async {
                                  date = await showDatePicker(context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(3000));
                                  // controller.aa!= date;
                                  controller.save(date);

                                  date2 = date;
                                  print(date2);
                                });
                              },
                                child: const Icon(
                                  Icons.date_range_sharp, color: Colors.white,),
                                color: Colors.blueAccent,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),),
                            ),
                            SizedBox(height: 5,),

                            Container(child: Text(   tapcntrl.aa==null?"XX:XX":tapcntrl.aa.toString().substring(0,11)   ,style: TextStyle(fontSize: 12,color: Colors.blue[800]),),),

                            SizedBox(height: 20,),
                            Row(
                              children: [
                                SizedBox(width: 10,),
                                SizedBox(
                                  width: 40,
                                  height: 40,

                                  child: ElevatedButton(onPressed: () async {
                                    time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now());

                                    setState(() {
                                      time2 = time;
                                      a11 = time2?.format(context).substring(
                                          0, 2);
                                      a12 = time2?.format(context).substring(3);

                                      String kkj = "${a11}:${a12}";
                                      controller.save1(kkj);
                                      print(a11);
                                      print(a12);

                                      b11 = int.parse(a11!);
                                      b12 = int.parse(a12!);


                                      print("done");

                                      // int a= int.parse((time2?.format(context).substring(0,2)));

                                    });
                                  }, child: Icon(CupertinoIcons.time),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueAccent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                50)),
                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0)
                                    ),
                                  ),
                                ),


                                Container(
                                  width: 132, height: 3, color: Colors.blue,),

                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: ElevatedButton(onPressed: () async {
                                    setState(() async {
                                      time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      time2 = time;
                                      a21 = time2?.format(context).substring(
                                          0, 2);
                                      a22 = time2?.format(context).substring(3);
                                      print(a21);
                                      print(a22);
                                      String kkl = "${a21}:${a22}";
                                      controller.save2(kkl);
                                      b21 = int.parse(a21!);
                                      b22 = int.parse(a22!);

                                      // int a= int.parse((time2?.format(context).substring(0,2)));

                                    });
                                  },
                                    child: Icon(CupertinoIcons.time_solid),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueAccent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                50)),
                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0)
                                    ),

                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),


                            Row(
                              children: [
                                SizedBox(width: 14,),
                                Container(width: 50,
                                  height: 35,
                                  child: Text( tapcntrl.bb==null? "": tapcntrl.bb.toString(),style: TextStyle(fontSize: 12,color: Colors.blue[800])),),
                                SizedBox(width: 124,),
                                Container(width: 40,
                                  height: 35,
                                  child: Text( tapcntrl.cc==null? "" :tapcntrl.cc.toString(),style: TextStyle(fontSize: 12,color: Colors.blue[800]),),),


                              ],
                            ),
                            SizedBox(height: 20,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () { Navigator.of(context).pop();
                                    _cntrl3.text="";
                                    },
                                  child: Text("cancle"),),
                                SizedBox(width: 20,),
                                ElevatedButton(onPressed: () {
                                  if (date2 != null) {
                                    setState(() {
                                      _getDS(
                                          _cntrl3.text,
                                          date2!.year,
                                          date2!.month,
                                          date2!.day,
                                          b11,
                                          b12,
                                          b21,
                                          b22);
                                    });
                                    controller.save(null);
                                    controller.save1("");
                                    controller.save2("");
                                  }
                                  Navigator.of(context).pop();
                                }, child: Text("save"),),


                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );

                }
              );
            }

        )
        ,
        backgroundColor: Color(0xff6499E9),
        child: Icon(CupertinoIcons.add),
      ),

      backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        child: Column(
          children: [


            Container(
              height: 600,
              // color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SfCalendar(

                  cellBorderColor: Colors.transparent,
                  headerHeight: 50,
                  headerStyle: CalendarHeaderStyle(
                    backgroundColor: Colors.blue.shade300,
                    textStyle: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center
                  ),
                  initialSelectedDate: DateTime.now(),
                  todayHighlightColor: Colors.lightBlueAccent,
                  dataSource: MeetingDataSource(meetings),
                  selectionDecoration: BoxDecoration(
                    border: Border.all(color: Color(0xff3085C3),width: 2,)
                  ),
                  // backgroundColor: Colors.blueGrey.shade800,
                  todayTextStyle: TextStyle(color: Colors.white),



                  view:(CalendarView.month),
                  controller: calendercntrl,
                  firstDayOfWeek: 1,

                  monthViewSettings: MonthViewSettings(
                    appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,

                    showAgenda: true
                  ),
                  timeSlotViewSettings: TimeSlotViewSettings(
                    startHour: 5,
                    endHour: 24
                  ),
                ),
              ),
            ),

            // Container(
            //   color: Colors.blue[100],
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(15, 10, 30, 10),
            //     child: Column(
            //       children: [
            //         Row(
            //           children: [
            //             Radio(value: 7,
            //                 groupValue: _value,
            //                 onChanged: (value){setState(() {
            //                   _value=value;
            //                   calendercntrl.view = calenderview[_value!];
            //
            //                 });}),
            //             Text("Schedule",style: TextStyle(fontSize: 16),)
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             Radio(value: 0,
            //                 groupValue: _value,
            //                 onChanged: (value){setState(() {
            //                   _value=value;
            //
            //                   calendercntrl.view = calenderview[_value!];
            //
            //                 });}),
            //             Text("Day Wise",style: TextStyle(fontSize: 16),)
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             Radio(value: 1,
            //                 groupValue: _value,
            //                 onChanged: (value){setState(() {
            //                   _value=value;
            //                   calendercntrl.view = calenderview[_value!];
            //
            //                 });}),
            //             Text("Week Wise",style: TextStyle(fontSize: 16),)
            //
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             Radio(value: 2,
            //                 groupValue: _value,
            //                 onChanged: (value){setState(() {
            //                   _value=value;
            //                   calendercntrl.view = calenderview[_value!];
            //
            //                 });}),
            //             Text("Month Wise",style: TextStyle(fontSize: 16),)
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             Radio(value: 3,
            //                 groupValue: _value,
            //                 onChanged: (value){setState(() {
            //                   _value=value;
            //                   calendercntrl.view = calenderview[_value!];
            //
            //                 });}),
            //             Text("Timeline-Day Wise",style: TextStyle(fontSize: 16),)
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             Radio(value: 4,
            //                 groupValue: _value,
            //                 onChanged: (value){setState(() {
            //                   _value=value;
            //                   calendercntrl.view = calenderview[_value!];
            //
            //                 });}),
            //             Text("Timeline-Week Wise",style: TextStyle(fontSize: 16),)
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             Radio(value: 5,
            //                 groupValue: _value,
            //                 onChanged: (value){setState(() {
            //                   _value=value;
            //                   calendercntrl.view = calenderview[_value!];
            //
            //                 });}),
            //             Text("Timeline-Month Wise",style: TextStyle(fontSize: 16),)
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             Radio(value: 6,
            //                 groupValue: _value,
            //                 onChanged: (value){setState(() {
            //                   _value=value;
            //                   calendercntrl.view = calenderview[_value!];
            //
            //                 });}),
            //             Text("Work-Week Wise",style: TextStyle(fontSize: 16),)
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // )






          ],
        ),
      ),
    );
  }
}





// Example calendar controller




// class Popupcal extends StatefulWidget {
//   DateTime? date,date2;
//   TimeOfDay? time,time2;
//   String? a11,a12,a21,a22;
//   int? b11,b12,b21,b22;
//   final cntrl3;
//   List<Meeting>? getDS;
//  Popupcal({
//     super.key,
//     required this.cntrl3,
//     required this.date,
//     required this.date2,
//     required this.time,
//     required this.time2,
//     required this.a11,
//     required this.a12,
//     required this.a21,
//     required this.a22,
//     required this.b11,
//     required this.b12,
//     required this.b21,
//     required this.b22,
//    required this.getDS,
//
//
//
// });
//
//   @override
//   State<Popupcal> createState() => _PopupcalState();
// }
//
// class _PopupcalState extends State<Popupcal> {
//   @override
//   // TODO: implement widget
//   Popupcal get widget => super.widget;
//   @override
//   Widget build(BuildContext context) {
//
//     return AlertDialog(
//       backgroundColor: Colors.blue[100],
//       content: SingleChildScrollView(
//         child: Container(
//           height: 370,
//           child: Column(
//             children: [
//               Container(height: 40 ,
//                 child: Text("ADD TASK",style: TextStyle(color: Colors.black,
//                   fontSize: 20,
//                   fontFamily: 'fira-M',
//                 ),
//
//                 ),
//
//               ),
//               TextField(controller: widget.cntrl3,decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Write a task...",),cursorColor: Colors.black,),
//               SizedBox(height: 15,),
//
//               SizedBox(
//                 width: 40,
//                 child: MaterialButton(onPressed: ()async{
//                   setState(()async {
//                     widget.date =  await  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(3000));
//                     widget.date2 = widget.date;
//                     print(widget.date2);
//
//                   });
//
//
//                 },child:const Icon(Icons.date_range_sharp,color: Colors.white,),color: Colors.blueAccent,padding: EdgeInsets.fromLTRB(0, 0, 0, 0),),
//               ),
//               SizedBox(height: 5,),
//
//               Container( child: Text("${widget.date2}"),),
//
//               SizedBox(height: 20,),
//               Row(
//                 children: [
//                   SizedBox(width: 10,),
//                   SizedBox(
//                     width: 40,
//                     height: 40,
//
//                     child: ElevatedButton(onPressed: ()async {
//                       widget.time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
//
//                       setState(() {
//
//                         widget.time2 = widget.time;
//                         widget.a11=widget.time2?.format(context).substring(0,2);
//                         widget.a12 = widget.time2?.format(context).substring(3);
//                         print(widget.a11);
//                         print(widget.a12);
//
//                         widget.b11 = int.parse(widget.a11!);
//                         widget.b12 = int.parse(widget.a12!);
//
//
//                         print("done");
//
//                         // int a= int.parse((time2?.format(context).substring(0,2)));
//
//                       });
//
//                     }, child: Icon(CupertinoIcons.time),
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blueAccent,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//                           padding: EdgeInsets.fromLTRB(0, 0, 0, 0)
//                       ),
//                     ),
//                   ),
//
//
//                   Container(width: 132,height: 3,color: Colors.blue,),
//
//                   SizedBox(
//                     height: 40,
//                     width: 40,
//                     child: ElevatedButton(onPressed: ()async{
//                       setState(() async{
//
//                         widget.time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
//                         widget.time2 = widget.time;
//                         widget.a21=widget.time2?.format(context).substring(0,2);
//                         widget.a22 = widget.time2?.format(context).substring(3);
//                         print(widget.a21);
//                         print(widget.a22);
//                         widget.b21 = int.parse(widget.a21!);
//                         widget.b22 = int.parse(widget.a22!);
//
//                         // int a= int.parse((time2?.format(context).substring(0,2)));
//
//                       });
//
//                     },
//                       child: Icon(CupertinoIcons.time_solid),
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blueAccent,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//                           padding: EdgeInsets.fromLTRB(0, 0, 0, 0)
//                       ),
//
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10,),
//
//
//               Row(
//                 children: [
//                   SizedBox(width: 11,),
//                   Container(width: 50,height: 35,child: Text("${}:${widget.b12!=null?widget.b12:"00"}"),),
//                   SizedBox(width: 120,),
//                   Container(width: 50,height: 35,child: Text("${(widget.b21!=null?widget.b21:"00")}:${widget.b22!=null?widget.b22:"00"}"),),
//
//
//                 ],
//               ),
//               SizedBox(height: 20,),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("cancle"),),
//                   SizedBox(width: 20,),
//                   ElevatedButton(onPressed: (){
//                     if(widget.date2!=null) {
//                       setState(() {
//                         widget.getDS(widget.cntrl3.text, widget.date2!.year, widget.date2!.month, widget.date2!.day, widget.b11, widget.b12,widget.b21,widget.b22);
//                       });
//
//
//                     }
//                     Navigator.of(context).pop();
//                   }, child: Text("save"),),
//
//
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

