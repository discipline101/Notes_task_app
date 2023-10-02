
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes/db/calenderDB.dart';
import 'package:notes/pages/calender/meeting.dart';
import 'package:notes/pages/calender/meeting_ds.dart';
import 'package:notes/pages/popup_calender.dart';
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
  calendb.loaddb();
  print("--------------------------------------------------------------------------------------------------------------------------------------start");
  print(calendb.meetings);
  if(calendb.meetings !=null) {
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




  void popup3(){
    showDialog(
        context: context,
        builder: (context){
          return  AlertDialog(
            backgroundColor: Colors.blue[100],
            content: SingleChildScrollView(
              child: Container(
                height: 370,
                child: Column(
                  children: [
                    Container(height: 40 ,
                      child: Text("ADD TASK",style: TextStyle(color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'fira-M',
                      ),

                      ),

                    ),
                    TextField(controller: _cntrl3,decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Write a task...",),cursorColor: Colors.black,),
                    SizedBox(height: 15,),

                    SizedBox(
                      width: 40,
                      child: MaterialButton(onPressed: ()async{
                        setState(()async {
                          date =  await  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(3000));
                          date2 = date;
                          print(date2);

                        });


                      },child:const Icon(Icons.date_range_sharp,color: Colors.white,),color: Colors.blueAccent,padding: EdgeInsets.fromLTRB(0, 0, 0, 0),),
                    ),
                    SizedBox(height: 5,),

                    Container( child: Text("${date2}"),),

                    SizedBox(height: 20,),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        SizedBox(
                          width: 40,
                          height: 40,

                          child: ElevatedButton(onPressed: ()async {
                            time = await showTimePicker(context: context, initialTime: TimeOfDay.now());

                            setState(() {

                            time2 = time;
                            a11=time2?.format(context).substring(0,2);
                            a12 = time2?.format(context).substring(3);
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
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0)
                            ),
                          ),
                        ),


                        Container(width: 132,height: 3,color: Colors.blue,),

                        SizedBox(
                          height: 40,
                          width: 40,
                          child: ElevatedButton(onPressed: ()async{
                            setState(() async{

                              time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                              time2 = time;
                              a21=time2?.format(context).substring(0,2);
                              a22 = time2?.format(context).substring(3);
                              print(a21);
                              print(a22);
                              b21 = int.parse(a21!);
                              b22 = int.parse(a22!);

                              // int a= int.parse((time2?.format(context).substring(0,2)));

                            });

                          },
                              child: Icon(CupertinoIcons.time_solid),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0)
                            ),

                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),


                    Row(
                      children: [
                        SizedBox(width: 11,),
                        Container(width: 50,height: 35,child: Text("${starttime()}:${b12!=null?b12:"00"}"),),
                        SizedBox(width: 120,),
                        Container(width: 50,height: 35,child: Text("${(b21!=null?b21:"00")}:${b22!=null?b22:"00"}"),),


                      ],
                    ),
                    SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("cancle"),),
                        SizedBox(width: 20,),
                        ElevatedButton(onPressed: (){
                          if(date2!=null) {
                            setState(() {
                              _getDS(_cntrl3.text, date2!.year, date2!.month, date2!.day, b11, b12,b21,b22);
                            });


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
    print("date is");
    print(date2);
  }




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

int? _value=1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:Color(0xff6499E9),
        title: Center(
          child: Text("CALENDER",style: TextStyle(fontSize: 20,color: Colors.white),)),),
      floatingActionButton: FloatingActionButton(
        onPressed: popup3,
        backgroundColor: Color(0xff6499E9),
        child: Icon(CupertinoIcons.add),
      ),

      backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        child: Column(
          children: [


            Container(
              height: 680,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SfCalendar(

                  cellBorderColor: Colors.transparent,
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
            Container(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 22,),
                  Icon(CupertinoIcons.eye_solid,size: 35.0,),

                  SizedBox(width: 72,),
                  Text("TASK FILTERS",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),

                ],
              )
              ,color: Colors.blue[100],width:500 ,),

            Container(
              color: Colors.blue[100],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 30, 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Radio(value: 7,
                            groupValue: _value,
                            onChanged: (value){setState(() {
                              _value=value;
                              calendercntrl.view = calenderview[_value!];

                            });}),
                        Text("Schedule",style: TextStyle(fontSize: 16),)
                      ],
                    ),
                    Row(
                      children: [
                        Radio(value: 0,
                            groupValue: _value,
                            onChanged: (value){setState(() {
                              _value=value;

                              calendercntrl.view = calenderview[_value!];

                            });}),
                        Text("Day Wise",style: TextStyle(fontSize: 16),)
                      ],
                    ),
                    Row(
                      children: [
                        Radio(value: 1,
                            groupValue: _value,
                            onChanged: (value){setState(() {
                              _value=value;
                              calendercntrl.view = calenderview[_value!];

                            });}),
                        Text("Week Wise",style: TextStyle(fontSize: 16),)

                      ],
                    ),
                    Row(
                      children: [
                        Radio(value: 2,
                            groupValue: _value,
                            onChanged: (value){setState(() {
                              _value=value;
                              calendercntrl.view = calenderview[_value!];

                            });}),
                        Text("Month Wise",style: TextStyle(fontSize: 16),)
                      ],
                    ),
                    Row(
                      children: [
                        Radio(value: 3,
                            groupValue: _value,
                            onChanged: (value){setState(() {
                              _value=value;
                              calendercntrl.view = calenderview[_value!];

                            });}),
                        Text("Timeline-Day Wise",style: TextStyle(fontSize: 16),)
                      ],
                    ),
                    Row(
                      children: [
                        Radio(value: 4,
                            groupValue: _value,
                            onChanged: (value){setState(() {
                              _value=value;
                              calendercntrl.view = calenderview[_value!];

                            });}),
                        Text("Timeline-Week Wise",style: TextStyle(fontSize: 16),)
                      ],
                    ),
                    Row(
                      children: [
                        Radio(value: 5,
                            groupValue: _value,
                            onChanged: (value){setState(() {
                              _value=value;
                              calendercntrl.view = calenderview[_value!];

                            });}),
                        Text("Timeline-Month Wise",style: TextStyle(fontSize: 16),)
                      ],
                    ),
                    Row(
                      children: [
                        Radio(value: 6,
                            groupValue: _value,
                            onChanged: (value){setState(() {
                              _value=value;
                              calendercntrl.view = calenderview[_value!];

                            });}),
                        Text("Work-Week Wise",style: TextStyle(fontSize: 16),)
                      ],
                    ),
                  ],
                ),
              ),
            )






          ],
        ),
      ),
    );
  }
}